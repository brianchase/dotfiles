
" ----- COLORS -----

set bg&                 " bg: Reset background
highlight clear         " hi: Clear all highlighting
if exists("syntax_on")
  syntax reset
endif

highlight Constant gui=NONE guibg=grey88  " hi: Adjust highlighting
highlight Cursor guibg=Gold guifg=NONE
highlight NonText guibg=grey75
highlight Normal guibg=grey97
highlight Special gui=NONE guibg=grey97

" ----- CURSOR -----

set guicursor=a:blinkon0 " gcr: Disable blinking in all modes

" Use cursor keys to move up and down lines in so-called screen space:
imap <up> <C-o>gk
map <up> gk
imap <down> <C-o>gj
map <down> gj

" ----- FONT -----

"set guifont=Dejavu\ Sans\ Mono\ 11
"set guifont=Hack\ 11
"set guifont=Inconsolata\ 12
set guifont=Source\ Code\ Pro\ 11

" ----- MOUSE -----

set nomousehide        " nomh:   Do not hide mouse while typing
"set mousemodel=extend  " mousem: Right mouse button opens a selection
"set mousemodel=popup   " mousem: Right mouse button opens a menu

" ----- TABS -----

set showtabline=1  " stal=1: Show tab line if more than one tab
"set showtabline=2  " stal=2: Always show tab line

" ----- MISCELLANEOUS -----

"set columns=74         " co: Set the number of columns
set display+=lastline  " Show incomplete lines
set guiheadroom=0      " ghr: Use entire screen height (for dwm)
"set lines=40           " Set the number of lines

" Use Ctrl-a in normal mode to select all:
map <C-a> ggVG

" Use Ctrl-f to open the search and replace dialog:
imap <C-f> <ESC>:promptrepl<CR>i
nmap <C-f> :promptrepl<CR>

set guioptions-=b  " go-=b: No bottom scrollbar
"set guioptions=c   " go=c: No popup dialogs
set guioptions-=m  " go-=m: No menu bar
"set guioptions-=r  " go-=r: No right scrollbar
set guioptions-=T  " go-=T: No toolbar

" For gvimdiff:
if &diff
"  set columns=140    " co: Set the number of columns
"  set guioptions+=b  " go: Add bottom scrollbar
  set guioptions-=L  " go: No left scrollbar
  set guioptions+=R  " go: Right scrollbar
  au VimResized * wincmd = " winc: Equal sized windows
endif
