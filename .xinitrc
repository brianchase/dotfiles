#!/bin/bash

# Set dwm's status bar:
[ -x "$(command -v status-dwm.sh)" ] && while true; do \
  status-dwm.sh; sleep 1m; done &

# Setup displays:
[ "$(xrandr | grep 'HDMI-1 connected')" ] && \
  xrandr --output LVDS-1 --auto --output HDMI-1 --auto --right-of LVDS-1 && \
  sleep 1

# Restore wallpaper:
[ -x "$(command -v $HOME/.config/feh/fehbg)" ] && $HOME/.config/feh/fehbg &

# Load Xresources:
[ -f "$HOME/.config/Xresources" ] && xrdb -merge $HOME/.config/Xresources

# Attach to a tmux session:
[ -x "$(command -v default-tmux.sh)" ] && st -e sh -c default-tmux.sh &

# Start dwm:
exec dwm
