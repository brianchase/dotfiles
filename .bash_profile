# ~/.bash_profile

# Set environment variables for Bash:
export HISTCONTROL=ignoreboth:erasedups # No duplicate entries in history, etc.
export HISTFILESIZE=0                   # Empty history on logout
export HISTSIZE=100                     # Until logout, keep 100 lines of history

# For less:
export LESS="-F -i -M -X" # Use these options
export LESSHISTFILE=-     # No history file ($HOME/.lesshst)

# For TeX Live:
[ -d "$HOME/.config/texmf" ] && export TEXMFHOME="$HOME/.config/texmf"

# For other applications:
[ -x "$(command -v firefox)" ] && export BROWSER="$(command -v firefox)"
[ -x "$(command -v vim)" ] && export EDITOR="$(command -v vim)"
[ -n "$EDITOR" ] && export VISUAL="$EDITOR"

# Add $HOME/.bin to PATH:
[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"

# Get additional settings from $HOME/.bashrc:
[ -f "$HOME/.bashrc" ] && source $HOME/.bashrc

# Upon first logging in at the console, start X:
[[ "$(tty)" = /dev/tty1 && -z "$DISPLAY" ]] && startx
