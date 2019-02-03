set nocompatible  " nocp: No backward compatibility with vi

" au!: Remove autocommands. Otherwise, they may cause trouble if you
" source this file again. Do not follow the command below with a
" comment on the same line.
autocmd!

" ----- ENCODING -----

set encoding=utf-8
set fileencoding=utf-8

" ----- CURSOR -----

set backspace=indent,eol,start  " bs: Set backspacing in Insert mode
set esckeys                     " ek: Allow cursor keys in insert mode
set nostartofline               " nosol: Keep cursor in same column
set ruler                       " ru: Show the cursor's position
set scrolloff=2                 " so: Minimum lines above and below the cursor
set whichwrap+=<,>,[,]          " ww: Allow cursor to cross line boundaries

" Follow links in Vim's documentation with Enter. Backspace goes back.
autocmd FileType help nmap <buffer> <Return> <C-]>
autocmd FileType help nmap <buffer> <BACKSPACE> <C-O>

" ----- HIGHLIGHTING IN SEARCH & VISUAL MODES -----

" At the console and in st (and possibly elsewhere), these settings
" ensure that highlighted text is visible, no matter how settings here
" and other in confuration files muck about with color.

highlight Search cterm=NONE term=NONE ctermbg=yellow ctermfg=black
highlight Visual cterm=reverse term=reverse ctermbg=black ctermfg=gray
" Necessary when attaching to a tmux session running vim:
highlight VisualNOS cterm=reverse term=reverse ctermbg=black ctermfg=gray

" ----- INDENTS/TABS -----

filetype indent off  " Turn off indent plugin
set expandtab        " et: Indent with spaces not tabs
set noautoindent     " noai: Disable autoindent
"set noexpandtab     " noet: Indent with tabs not spaces
set shiftround       " sr: Rounds indent to a multiple of shiftwidth
set shiftwidth=2     " sw: Spaces per autoindent
set smarttab         " sta: Helps with backspacing due to expandtab
set tabstop=2        " ts: Spaces per tab

" For some files, indent with tabs not spaces:
autocmd BufNewFile,BufRead *.css,*.htm,*.html set noexpandtab

" Open new tabs:
imap <C-t> <ESC>:tabnew<CR>
map <C-t> :tabnew<CR>

" ----- LATEX -----

" Add these to the list of TeX files:
autocmd BufReadPre *.bbx,*.cbx,*.lbx set filetype=tex

" Import a template for new TeX files:
autocmd BufNewFile *.tex set ft=tex | call TexTemplate()

" Keymaps for jumping to placeholders in template:
nnoremap <C-p> /!\u.\{-1,}!<cr>c/!/e<cr>
inoremap <C-p> <ESC>/!\u.\{-1,}!<cr>c/!/e<cr>

" Keymaps for viewing PDF:
imap <silent> <F3> <ESC>:call ViewFile("pdf","zathura")<ESC>a
map <silent> <F3> :call ViewFile("pdf","zathura")<CR>

" Keymaps for viewing *.log:
imap <silent> <F4> <ESC>:call ViewFile("log","gvim")<ESC>a
map <silent> <F4> :call ViewFile("log","gvim")<CR>

" Keymaps for compiling (LaTeX):
imap <silent> <F5> <ESC>:call TeX("-pdf")<ESC>a
map <silent> <F5> :call TeX("-pdf")<CR>

" Keymaps for compiling (XeTeX):
imap <silent> <F6> <ESC>:call TeX("-xelatex")<ESC>a
map <silent> <F6> :call TeX("-xelatex")<CR>

" ----- LINE WRAPPING -----

set formatoptions=clq  " fo: Set format options
set nowrap             " Don't wrap long lines to fit the window
set showbreak=+++\     " sbr: Show this string at line wraps
set textwidth=70       " tw: Set text width

" Format options for certain files:
autocmd FileType text setlocal formatoptions=aq

" Keymaps to rewrap the current paragraph or selected text in visual
" mode and then move the cursor to the next paragraph. To leave the
" cursor at its original position, replace 'gqap' below with 'gwap'.
imap <F2> <ESC>gqap<CR>i
nmap <F2> gqap
vmap <F2> gqap

" Keymaps to toggle line wrapping:
imap <silent> <F9> <ESC>:call ToggleLineWrap()<ESC>a
map <silent> <F9> :call ToggleLineWrap()<CR>

" Toggle line wrapping:
function! ToggleLineWrap()
  if expand(&wrap) == "1"
    setl nowrap
  else
    setl wrap
  endif
endfunction

" Keymaps to toggle formatoptions '-a' and '+a':
imap <silent> <F10> <ESC>:call ToggleWrap()<ESC>a
map <silent> <F10> :call ToggleWrap()<CR>

" Keymaps to toggle formatoptions 'aq' and 'aclq':
imap <silent> <F11> <ESC>:call ToggleFo()<ESC>a
map <silent> <F11> :call ToggleFo()<CR>

function! ToggleWrap()
  if expand(&fo) == "aq"
    setl fo=q
  elseif expand(&fo) == "q"
    setl fo=aq
  elseif expand(&fo) == "aclq"
    setl fo=clq
  elseif expand(&fo) == "clq"
    setl fo=aclq
  endif
endfunction

function! ToggleFo()
  if expand(&fo) == "clq" || "aclq"
    setl fo=aq
  else
    setl fo=clq
  endif
endfunction

" ----- PRINT -----

set printdevice=HL-2270DW  " pdev: Set printer for use with 'hardcopy'
set printencoding=utf-8    " penc: Character encoding for printer

" Set printing options (US letter paper, portrait, no syntax highlighting):
"set printoptions=paper:letter,portrait:y,syntax:n  " popt:
set printoptions=paper:letter,portrait:n,syntax:n  " popt:

" Use hc to print a file in normal mode:
"nmap hc :hardcopy<CR>

" Use ps to make a postscript file:
"nmap ps :hardcopy >%.ps<CR>

" ----- SEARCH -----

set ignorecase  " ic: Case insensitive searches by default
set incsearch   " is: Incremental searching
set hlsearch    " hls: Search pattern highlighting
"set path=.,**   " pa: Search current directory and subdirectories
set smartcase   " scs: Overrides ignorecase for uppercase patterns

" Search for visually selected text:
vmap s y/<C-R>=escape(@",'/\')<CR><CR>

" ----- SPELLING -----

" Spell checking for certain files:
autocmd FileType bib,text setlocal spell

set spelllang=en_us
set spellfile=~/.vim/spellfile.add

" Toggle spell-checking:
imap <silent> <F7> <ESC>:set nospell!<CR>a
nmap <silent> <F7> :set nospell!<CR>

" Never highlight rare or uncapitalized words:
highlight SpellCap ctermbg=NONE ctermfg=NONE gui=NONE
highlight SpellRare ctermbg=NONE ctermfg=NONE gui=NONE

" Underline misspelled and nonlocal words:
highlight SpellBad cterm=underline ctermbg=NONE ctermfg=red
highlight SpellLocal cterm=underline ctermbg=NONE ctermfg=blue

" To keep the previous settings for mispelled and nonlocal words,
" while toggling syntax highlighting on and off (see the Syntax
" section below), run this after syntax highlighting is toggled on:
function! HighlightSpelling()
  highlight SpellBad cterm=underline ctermbg=NONE ctermfg=red
  highlight SpellLocal cterm=underline ctermbg=NONE ctermfg=blue
endfunction

" ----- STATUS LINE -----

set laststatus=2  " ls: Always show the status line
set statusline=%<%F%h%m%r%h%w\ [%{&fo}]\ %=\ %l\,%c\ %P
highlight StatusLine cterm=reverse term=reverse

" ----- SYNTAX -----

" Set syntax highlighting so that toggling it with ToggleSyntax()
" affects only the current buffer.

" If necessary, automatically clear syntax highlighting:
autocmd BufEnter * call SynClear()

" Toggle syntax highlighting:
imap <silent> <F8> <ESC>:call ToggleSyntax()<ESC>a
nmap <silent> <F8> :call ToggleSyntax()<CR>

" For files in ~/.vim/ftplugin:
function! AutoSyn()
  syntax on sync fromstart
  exec HighlightSpelling()
  let b:syn_flg = "1"
endfunction

function! SynClear()
  if !exists("b:syn_flg")
    syntax clear
    let b:syn_flg = "0"
  elseif b:syn_flg == 0
    syntax clear
  endif
endfunction

function! ToggleSyntax()
  if b:syn_flg == 1
    syntax clear
    let b:syn_flg = "0"
  else
    syntax enable
    exec HighlightSpelling()
    let b:syn_flg = "1"
  endif
endfunction

" ----- TIMESTAMPS -----

" Adapted from Seth Mason at http://www.slackorama.com/

" %a - Abbreviated weekday (Sat)
" %A - Full weekday (Saturday)
" %b - Abbreviated month (Jan)
" %B - Full month (January)
" %d - Day of the month
" %H - Hour (00--23)
" %I - Hour (01--12)
" %m - Month (01--12)
" %M - Minute
" %S - Seconds
" %X - %H:%M:%S
" %Y - Year
" %Z - Time Zone

function! UpdateTimeStampA()
  if &modified == 1
    exec "1"
    let modified_line_no = search("Last modified: ")
    if modified_line_no != 0 && modified_line_no < 3
      exe "s/Last modified: .*/" . TimeStampA()
    endif
  endif
endfunction

function TimeStampA()
  return "Last modified: " . strftime("%a %d %b %Y %I:%M:%S %p %Z")
endfunction

" Update time stamps before writing certain files:
autocmd FileType tex,text autocmd BufWritePre * ks|call UpdateTimeStampA()|'s

" ----- MISCELLANEOUS -----

set autoread                  " ar: Reread file when changed from outside
set autowrite                 " aw: Write a modified file on certain events
set backupdir=~/.vim/         " bdir: Set backup directory
set clipboard=unnamedplus     " Access X11 clipboard (Ctrl+C, Ctrl+V, etc.)
set cpoptions-=a              " cpo: After ":read", no alternate file name
set fileformats=unix,dos,mac  " ffs: These file formats, in this order
filetype plugin on            " Turn on filetype detection and plugin
set history=50                " Save this much history
set lazyredraw                " lz: Disable redraw while running macros
set matchtime=2               " mat: Tenths of a second for showing matches
set nofoldenable              " nofen: Turn off folding
set nohidden                  " nohid: No hidden buffers
set nojoinspaces              " nojs: Just one space after '.', '?', and '!'
set nomodeline                " noml: Disable mode lines
set noshowcmd                 " nosc: Do not show commands
set noswapfile                " noswf: Disable swap file
"set pastetoggle=<F11>         " pt: No indenting when pasting
set shortmess=aoOtTAI         " shm: Shorten messages
set showmatch                 " sm: Show matching [], {}, and ()
"set termguicolors             " tbc: Use 24-bit color (avoid with current setup)
set ttyfast                   " tf: No modem connections; redraws faster
set viminfo=""                " Disable viminfo
set wildmenu                  " wmnu: Tab completion for help and commands

" Suffixes with lower priority in the tab completion of filenames:
set suffixes+=~,.aux,.bak,.bbl,.bcf,.bib,.blg,.bm,.end,.fdb_latexmk,.fls,.hyp,.idx,.info,.lo,.lof,.log,.lot,.out,.xml

" Ignore these files (asterisks necessary):
set wildignore+=*.doc,*.dvi,*.eps,*.jpg,*.o,*.odt,*.pdf,*.png,*.ps,*.rtf,*.swp,*.url

" Keymaps for deleting trailing spaces and DOS returns:
imap <silent> <F12> <ESC>:call DelWhiteDOS()<ESC>a
nmap <silent> <F12> :call DelWhiteDOS()<CR>

" Delete trailing spaces and DOS returns before writing certain files:
autocmd FileType markdown,sh,tex,text,vim autocmd BufWritePre * :call DelWhiteDOS()

function! DelWhiteDOS()
  if ! &bin
    let save_cursor = getpos(".")
    silent! :%s#\s*\r*$##
    call histdel("search", -1)
    call setpos('.', save_cursor)
  endif
endfunction

" Open list of buffers:
"imap <silent> <C-b> <ESC>:buffers<CR>:buffer<Space>
"map <silent> <C-b> :buffers<CR>:buffer<Space>

" Add these to the list of markdown files:
autocmd BufRead,BufNewFile *.md,*.markdown,*.mkd set filetype=markdown

if &foldmethod == 'diff'
  set scrollbind  " scb: Scroll windows at the same time
endif
