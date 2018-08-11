#!/bin/bash

# Load Xresources:
[ -f "$HOME/.config/Xresources" ] && xrdb -merge $HOME/.config/Xresources

# Alt+CapsLock toggles English and Greek keyboard layouts:
#setxkbmap us,el -variant ,polytonic -option grp:alt_caps_toggle,grp_led:scroll

# Set dwm's status bar:
[ -x "$(command -v status-dwm.sh)" ] && while true; do \
  status-dwm.sh; sleep 1m; done &

# Restore wallpaper:
[ -x "$(command -v $HOME/.fehbg)" ] && $HOME/.fehbg &

# Attach to a tmux session:
[ -x "$(command -v default-tmux.sh)" ] && st -e sh -c default-tmux.sh &

# Start dwm:
exec dwm
