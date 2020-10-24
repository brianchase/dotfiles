#!/bin/bash

# Resides in: /usr/local/bin/
# For use with: /etc/udev/rules.d/95-monitor.rules

# Note: Assumes two monitors: eDP-1 (laptop's default, always
# connected) and DP-1, an external monitor.

N=0
until [ "$N" = 5 ]; do
  ((N += 1))
  readarray -t MonArr1 < <(xrandr | awk '/ connected /{print $1}')
  for i in "${!MonArr1[@]}"; do
    if [ "${MonArr1[i]}" = DP-1 ]; then
      xrandr --output eDP-1 --auto --output DP-1 --mode 2560x1440 --right-of eDP-1
      exit
    fi
    sleep 1
  done
done
if [ "${MonArr1[@]}" = eDP-1 ]; then
  xrandr --output eDP-1 --auto --output DP-1 --off
fi
