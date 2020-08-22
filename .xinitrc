#!/bin/bash

# Load Xresources:
[ -f "$HOME/.config/Xresources" ] && xrdb -merge $HOME/.config/Xresources

# Alt+CapsLock toggles English and Greek keyboard layouts:
#setxkbmap us,el -variant ,polytonic -option grp:alt_caps_toggle,grp_led:scroll

# Set dwm's status bar:
[ -x "$(command -v status-dwm.sh)" ] && while true; do \
  status-dwm.sh; sleep 1m; done &

# Setup displays:
[ "$(xrandr | grep 'HDMI-1 connected')" ] && \
  xrandr --output LVDS-1 --auto --output HDMI-1 --auto --right-of LVDS-1 &

# Restore wallpaper:
[ -x "$(command -v $HOME/.config/feh/fehbg)" ] && $HOME/.config/feh/fehbg &

# Attach to a tmux session:
[ -x "$(command -v default-tmux.sh)" ] && st -e sh -c default-tmux.sh &

# Start dwm:
exec dwm
