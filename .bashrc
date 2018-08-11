# ~/.bashrc

# Test for interactive shell:
[[ $- != *i* ]] && return

# Set prompt:
case $UID in
  0) PS1="\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] " ;;
  *) PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] " ;;
esac

# Use colors:
use_color=true
[ -x "$(command -v dircolors)" ] && [ -r "$HOME/.config/dircolors" ] \
  && eval "$(dircolors -b $HOME/.config/dircolors)"

complete -cf man  # Complete after man
#complete -cf sudo # Complete after sudo

# Set aliases:
alias ls="ls --color=auto"
[ -n "$EDITOR" ] && alias notes="$EDITOR $HOME/.config/notes"
[ -x "$(command -v online-xsetroot.sh)" ] && alias online="online-xsetroot.sh"
[ -x "$(command -v vpn-xsetroot.sh)" ] && alias vpn="vpn-xsetroot.sh $1 $2"
