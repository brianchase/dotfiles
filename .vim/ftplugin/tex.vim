" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer.
let b:did_ftplugin = 1

" Avoid problems if running in 'compatible' mode.
let s:save_cpo = &cpo
set cpo&vim

" Always use latex syntax highlighting for tex files:
let g:tex_flavor = "latex"

" Set 'commentstring' to recognize the % comment character:
setlocal cms=%%s

" Set format options and spell checking for *.tex files:
if expand("%:e") == "tex"
  setlocal formatoptions=aq
  setlocal spell
endif

" Set syntax highlighting:
exec AutoSyn()

" Adapted from http://vim.runpaint.org/typing/using-templates/

function! TexTemplate()
  silent! 0r ~/.config/texmf/tex/latex/paper.tex
  set fo-=a
  syn match Todo "!\u\+!" containedIn=ALL
endfunction

function! ViewFile(ext,app)
  let targ = expand("%:r") . "." . a:ext
  if !executable(a:app)
    echomsg a:app 'is not executable'
  elseif filereadable(targ)
    silent execute '!' . a:app . ' ' . shellescape(targ) . ' &'
  else
    echomsg targ 'is unreadable'
  endif
endfunction

" ----- COMPILING -----

function! TeX(opt)
  let targ = expand("%:t")
  let pdt = search("{powerdot}")
  if pdt != 0 && pdt < 3
    let flg = "-pdfps"
  else
    let flg = a:opt
  endif
  echomsg "compiling..."
  let s:origdir = getcwd()
  cd %:p:h
  silent execute '!latexmk -C'
  silent execute '!latexmk -bibtex -f ' . flg . ' -silent ' . targ
  call ErrorCheck()
  call Tex_CD(s:origdir)
" Clear previous message (recently became necessary):
  echo ""
endfunction

function! ErrorCheck()
  let log = expand("%:r") . "." . "log"
  try
    silent execute 'vimgrep /^!/ ' . log
    copen
    catch /^Vim\%((\a\+)\)\=:E480/
  endtry
endfunction

" ----- FOR IMAPS.VIM -----

call IMAP('em`', '\emph{<++>}', 'tex')
call IMAP('gr`', '\grk{<++>}', 'tex')
call IMAP('bf`', '\textbf{<++>}', 'tex')
call IMAP('it`', '\textit{<++>}', 'tex')
call IMAP('md`', '\textmd{<++>}', 'tex')
call IMAP('sc`', '\textsc{<++>}', 'tex')
call IMAP('sf`', '\textsf{<++>}', 'tex')
call IMAP('tt`', '\texttt{<++>}', 'tex')
call IMAP('un`', '\underline{<++>}', 'tex')

call IMAP('1`', '\chapter{<++>}', 'tex')
call IMAP('2`', '\section{<++>}', 'tex')
call IMAP('3`', '\subsection{<++>}', 'tex')
call IMAP('4`', '\subsubsection{<++>}', 'tex')

call IMAP('bc`', "\\begin{center}<++>\\end{center}", "tex")
call IMAP('bd`', "\\begin{description}\<CR>\<CR>\\item[<++>]\<CR>\<CR>\\end{description}", "tex")
call IMAP('be`', "\\begin{enumerate}\<CR>\<CR>\\item <++>\<CR>\<CR>\\end{enumerate}", "tex")
call IMAP('bi`', "\\begin{itemize}\<CR>\<CR>\\item <++>\<CR>\<CR>\\end{itemize}", "tex")
call IMAP('bq`', "\\begin{quote}<++>\\end{quote}", "tex")
call IMAP('bvb`', "\\begin{verbatim}<++>\\end{verbatim}", "tex")
call IMAP('bvs`', "\\begin{verse}<++>\\end{verse}", "tex")

call IMAP('c`', "\\cite{<++>}", "tex")
call IMAP('fn`', "\\footnote{<++>}", "tex")
call IMAP('i`', "\\item ", "tex")
call IMAP('up`', "\\usepackage{<++>}", "tex")
call IMAP ('m`', "$<++>$", "tex")

" Key maps for enclosing selected text in visual mode:
vmap em` "zdi\emph{<C-R>z}<ESC>
vmap bf` "zdi\textbf{<C-R>z}<ESC>
vmap it` "zdi\textit{<C-R>z}<ESC>
vmap md` "zdi\textmd{<C-R>z}<ESC>
vmap sf` "zdi\textsf{<C-R>z}<ESC>
vmap tt` "zdi\texttt{<C-R>z}<ESC>
vmap un` "zdi\underline{<C-R>z}<ESC>

vmap 1` "zdi\chapter{<C-R>z}<ESC>
vmap 2` "zdi\section{<C-R>z}<ESC>
vmap 3` "zdi\subsection{<C-R>z}<ESC>
vmap 4` "zdi\subsubsection{<C-R>z}<ESC>

vmap bc` "zdi\begin{center} <C-R>z \\end{center}<ESC>
vmap bq` "zdi\begin{quote} <C-R>z \end{quote}<ESC>
vmap bvb` "zdi\begin{verbatim} <C-R>z \\end{verbatim}<ESC>
vmap bvs` "zdi\begin{verse} <C-R>z \\end{verse}<ESC>

vmap c` "zdi\cite{<C-R>z}<ESC>
vmap fc` "zdi\footcite{<C-R>z}<ESC>
vmap fn` "zdi\footnote{<C-R>z}<ESC>
vmap up` "zdi\usepackage{<C-R>z}<ESC>
vmap m` "zdi$<C-R>z$<ESC>

" ----- FROM VIM LATEX SUITE -----

" Tex_CD: cds to given directory escaping spaces if necessary
function! Tex_CD(dirname)
  exec 'cd '.Tex_EscapeSpaces(a:dirname)
endfunction
" Tex_EscapeSpaces: escapes unescaped spaces from a path name
function! Tex_EscapeSpaces(path)
  return substitute(a:path, '[^\\]\(\\\\\)*\zs ', '\\ ', 'g')
endfunction

" TexQuotes: inserts `` or '' instead of "
" Taken from texmacro.vim by Benji Fisher <benji@e-math.AMS.org>
" TODO:  Deal with nested quotes.
" The :imap that calls this function should insert a ", move the cursor to
" the left of that character, then call this with <C-R>= .
function! s:TexQuotes()
  let l = line(".")
  let c = col(".")
  let restore_cursor = l . "G" . virtcol(".") . "|"
  normal! H
  let restore_cursor = "normal!" . line(".") . "Gzt" . restore_cursor
  execute restore_cursor
" In math mode, or when preceded by a \, just move the cursor past the
" already-inserted " character.
  if synIDattr(synID(l, c, 1), "name") =~ "^texMath"
    \ || (c > 1 && getline(l)[c-2] == '\')
    return "\<Right>"
  endif
  let open = "``"
  let close = "''"
  let boundary = '\|'

  " Eventually return q; set it to the default value now.
  let q = open
  let pattern =
    \ escape(open, '\~') .
    \ boundary .
    \ escape(close, '\~') .
    \ '\|^$\|"'

  while 1	" Look for preceding quote (open or close), ignoring
  " math mode and '\"' .
    call search(pattern, "bw")
    if synIDattr(synID(line("."), col("."), 1), "name") !~ "^texMath"
      \ && strpart(getline('.'), col('.')-2, 2) != '\"'
      break
    endif
  endwhile

  " Now, test whether we actually found a _preceding_ quote; if so, is it
  " an open quote?
  if ( line(".") < l || line(".") == l && col(".") < c )
    if strpart(getline("."), col(".")-1) =~ '\V\^' . escape(open, '\')
      if line(".") == l && col(".") + strlen(open) == c
        " Insert "<++>''<++>" instead of just "''".
        let q = IMAP_PutTextWithMovement("<++>".close."<++>")
      else
        let q = close
      endif
    endif
  endif

  " Return to line l, column c:
  execute restore_cursor
  " Start with <Del> to remove the " put in by the :imap .
  return "\<Del>" . q

endfunction

inoremap <buffer> <silent> " "<Left><C-R>=<SID>TexQuotes()<CR>
inoremap <buffer> <silent> . <C-R>=<SID>SmartDots()<CR>

" The next function borrows part of a function by the same name in Vim
" LaTeX Suite:

function! <SID>SmartDots()
  if strpart(getline('.'), col('.')-3, 2) == '..'
    return "\<bs>\<bs>\\ldots"
  else
    return '.'
  endif
endfunction

let &cpo = s:save_cpo
