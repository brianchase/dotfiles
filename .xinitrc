#!/bin/bash

# Set dwm's status bar:
[ -x "$(command -v status-dwm.sh)" ] && while true; do \
  status-dwm.sh; sleep 1m; done &

# Load Xresources:
[ -f "$HOME/.Xresources" ] && xrdb -merge $HOME/.Xresources

# Restore wallpaper:
[ -x "$(command -v $HOME/.config/feh/fehbg)" ] && $HOME/.config/feh/fehbg &

# Attach to a tmux session:
[ -x "$(command -v default-tmux.sh)" ] && st -e sh -c default-tmux.sh &

# Start dwm:
exec dwm
