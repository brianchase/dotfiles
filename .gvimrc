
" ----- COLORS -----

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

set nomousehide         " nomh:   Do not hide mouse while typing
"set mousemodel=extend   " mousem: Right mouse button opens a selection
"set mousemodel=popup    " mousem: Right mouse button opens a menu

" ----- TABS -----

set showtabline=1  " stal=1: Show tab line if more than one tab

" ----- MISCELLANEOUS -----

set display+=lastline  " Show incomplete lines

" Use Ctrl-a in normal mode to select all:
map <C-a> ggVG

" Use Ctrl-f to open the search and replace dialog:
imap <C-f> <ESC>:promptrepl<CR>i
nmap <C-f> :promptrepl<CR>

"set guioptions-=b  " go-=b: Disable bottom scrollbar
"set guioptions=c   " go=c: Disable popup dialogs
set guioptions-=m  " go-=m: Disable menu bar
"set guioptions-=r  " go-=r: Disable right scrollbar
set guioptions-=T  " go-=T: Disable toolbar

set columns=74  " co: Set the number of columns
" Avoid if using with dwm:
"set lines=40  " Set the number of lines

" Use gvimdiff with a wider window and bottom scrollbar:
if &foldmethod == 'diff'
  set columns=140    " co: Set the number of columns
  set guioptions+=b  " go: Add bottom scrollbar
  set guioptions-=L  " go: No left scrollbar for vertically split windows
  set guioptions+=R  " go: Right scrollbar for vertically split windows
endif
