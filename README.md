# dotfiles

## About

My dotfiles repository is small. I've left out files that I backup
elsewhere but don't use, maintain, or especially care about or don't
see a point in making public. What's left is the core my collection,
what I fuss over the most. It's also what others are most likely to
find useful.

## Settings for Vim

With a few exceptions, all the relevant files are here:

* [.vimrc](https://github.com/brianchase/dotfiles/blob/master/.vimrc ".vimrc")
* [.gvimrc](https://github.com/brianchase/dotfiles/blob/master/.gvimrc ".gvimrc")
* [.vim/](https://github.com/brianchase/dotfiles/tree/master/.vim ".vim")

The exceptions are several files not included here: my spellfiles and
a template for blank TeX files, loaded by my
[tex.vim](https://github.com/brianchase/dotfiles/blob/master/.vim/ftplugin/tex.vim
"tex.vim").

Since I often use [Vim](https://www.vim.org "Vim") for writing, my
settings allow for dynamic word wrapping, which I can toggle on or off
in the current buffer without affecting the others. The result is a
setup that gives a lot of attention to TeX documents but not much to
other file types. A list of how I use function keys can serve as a
broad overview of features:

* <kbd>F2</kbd>: Runs `gqap` at the current position. In effect, it
wraps the text of the paragraph under the cursor, then moves the
cursor to the next one.
* <kbd>F3</kbd>: Attempts to open a PDF file in
[zathura](https://pwmt.org/projects/zathura "zathura") with the same
basename as the file in the buffer. If the buffer contains a TeX
document, I can use this to view the compiled PDF.
* <kbd>F4</kbd>: Attempts to open a log file with the same basename
as the file in the buffer. As with the previous keymap, I use it with
Tex documents.
* <kbd>F5</kbd>: Commented out. Attempts to compile the
current buffer with [latexmk](https://ctan.org/pkg/latexmk?lang=en
"latexmk"), with the option `-pdf`. If the file uses the
[powerdot](https://ctan.org/pkg/powerdot "powerdot") class, the
function swaps `-pdf` for `-pdfps`. If the compilation encounters an
error, the function highlights the error message and opens the log
file to the corresponding location.
* <kbd>F6</kbd>: Attempts to compile the current buffer with latexmk,
with the option `-xelatex`. Similar to the previous keymap, if the
file uses the [powerdot](https://ctan.org/pkg/powerdot "powerdot")
class, the function swaps `-xelatex` for `-pdfps`. If the compilation
encounters an error, the function highlights the error message and
opens the log file to the corresponding location.
* <kbd>F7</kbd>: Toggles spell checking in the current buffer. Spell
checking is on by default for certain file types and set to `en_us`.
* <kbd>F8</kbd>: Toggles syntax highlighting in the current buffer.
Syntax highlighting is off by default for most file types.
* <kbd>F9</kbd>: Toggles `wrap` and `nowrap` in the current buffer.
The default is `nowrap`.
* <kbd>F10</kbd>: Toggles formatoptions `-a` and `+a` in the current buffer.
* <kbd>F11</kbd>: Toggles `formatoptions` `aq` and `aclq` in the
current buffer. By default, `formatoptions` is `aq` for certain file
types.
* <kbd>F12</kbd>: Deletes trailing spaces and DOS returns in the
current buffer. This happens automatically before writing certain file
types.

## Scripts

My
[.bashrc](https://github.com/brianchase/dotfiles/blob/master/.bashrc
".bashrc") and
[.xinitrc](https://github.com/brianchase/dotfiles/blob/master/.xinitrc
".xinitrc") run scripts in my local
[.bin](https://github.com/brianchase/dotfiles/.bin ".bin"). I've
included those scripts in this repository, along with others that I'm
fond of but that don't merit their own projects.

* [chk-http.sh](https://github.com/brianchase/dotfiles/blob/master/.bin/chk-http.sh
 "chk-http.sh"): Checks for an internet connection. If the system is
offline, it can run my
[online-wpa.sh](https://github.com/brianchase/dotfiles/blob/master/.bin/online-wpa.sh
"online-wpa.sh") to connect, then update the status bar in
[dwm](http://dwm.suckless.org "dwm").
* [compile-tex.sh](https://github.com/brianchase/dotfiles/blob/master/.bin/compile-tex.sh
"compile-tex.sh"): Compiles TeX documents. This is handy in rare
emergencies when compiling in [Vim](https://www.vim.org "Vim") hides
key error messages in stdout that don't appear in log files.
* [default-tmux.sh](https://github.com/brianchase/dotfiles/blob/master/.bin/default-tmux.sh
"default-tmux.sh"): Starts or reattaches to my default
[tmux](https://github.com/tmux/tmux/wiki "tmux") session.
* [online-wpa.sh](https://github.com/brianchase/dotfiles/blob/master/.bin/online-wpa.sh
"online-wpa.sh"): Manages wireless connectivity with
[wpa_supplicant](https://w1.fi/wpa_supplicant "wpa_supplicant") and
optionally starts and stops [OpenVPN](https://openvpn.net "OpenVPN")
clients with my
[client-openvpn.sh](https://github.com/brianchase/client-openvpn
"client-openvpn.sh")
* [snip-pdf.sh](https://github.com/brianchase/dotfiles/blob/master/.bin/snip-pdf.sh
"snip-pdf.sh"): Extracts a range of pages from a PDF file. It uses
[QPDF](http://qpdf.sourceforge.net "QPDF") or, as a fallback,
[Ghostscript](https://www.ghostscript.com "Ghostscript").
* [status-dwm.sh](https://github.com/brianchase/dotfiles/blob/master/.bin/status-dwm.sh
"status-dwm.sh"): Sets the root window parameter for the status bar in
[dwm](http://dwm.suckless.org "dwm").

## License

This project is in the public domain under [The
Unlicense](https://choosealicense.com/licenses/unlicense "The
Unlicense").

