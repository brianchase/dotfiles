# ~/.bashrc

# Test for interactive shell:
[[ $- != *i* ]] && return

# Set prompt:
case $EUID in
  0) PS1="\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] " ;;
  *) PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] " ;;
esac

# After commands, update LINES and COLUMNS:
[ -n "$DISPLAY" ] && shopt -s checkwinsize

# Use colors:
use_color=true
[ -x "$(command -v dircolors)" ] && [ -r "$HOME/.config/dircolors" ] \
  && eval "$(dircolors -b $HOME/.config/dircolors)" || eval "$(dircolors -b)"

# Tab completion after man and sudo:
complete -c man sudo

# Remove Bash history file (empty per my ~/.bash_profile):
[ -f "$HISTFILE" ] && rm $HISTFILE

# Aliases and functions:
alias ls="ls --color=auto"
[ -n "$EDITOR" ] && alias notes="$EDITOR $HOME/.config/notes"
chk_id () { if [ "$(id -u)" -eq 0 ]; then "$@"; else sudo "$@"; fi; }
lcd_off () { sleep 1; xset dpms force off && slock; }
nwk () { online-wpa.sh && status-dwm.sh; }
pac () { chk-http.sh && chk_id "pacman" "-S" "$@"; }
rns () { [ "$(pacman -Qdqt)" ] && chk_id "pacman" "-Rns" $(pacman -Qdqt); }
syu () { chk-http.sh && chk_id "pacman" "-Syu"; }
vpn () { client-openvpn.sh "$@" && sleep 2 && status-dwm.sh; }
export -f lcd_off

# References:
# chk-http.sh: https://github.com/brianchase/dotfiles/.bin
# client-openvpn.sh: https://github.com/brianchase/client-openvpn
# dircolors: https://github.com/brianchase/dotfiles/.config
# online-wpa.sh: https://github.com/brianchase/dotfiles/.bin
# status-dwm.sh: https://github.com/brianchase/dotfiles/.bin
