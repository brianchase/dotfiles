# ~/.bashrc

# Test for interactive shell:
[[ $- != *i* ]] && return

# Set prompt:
case $UID in
  0) PS1="\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] " ;;
  *) PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] " ;;
esac

# After commands, update LINES and COLUMNS:
[ -n "$DISPLAY" ] && shopt -s checkwinsize

# Use colors:
use_color=true
[ -x "$(command -v dircolors)" ] && [ -r "$HOME/.config/dircolors" ] \
  && eval "$(dircolors -b $HOME/.config/dircolors)" || eval "$(dircolors -b)"

# Tab completion after man:
complete -c man

# Remove Bash history file (it's empty per ~/.bash_profile):
[ -f "$HISTFILE" ] && rm $HISTFILE

# Aliases and functions:
alias ls="ls --color=auto"
[ -n "$EDITOR" ] && alias notes="$EDITOR $HOME/.config/notes"
ol () { online-netctl.sh && status-dwm.sh; }
vpn () { client-openvpn.sh "$1" "$2" && sleep 2 && status-dwm.sh; }

# References:
# client-openvpn.sh: https://github.com/brianchase/client-openvpn
# dircolors: https://github.com/brianchase/dotfiles/.config
# online-netctl.sh: https://github.com/brianchase/online-netctl
# status-dwm.sh: https://github.com/brianchase/dotfiles/.bin
