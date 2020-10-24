#!/bin/bash

# Note: Assumes two monitors: eDP-1 (laptop's default, always
# connected) and DP-1, an external monitor.

chk_monitor () {
  for j in "${!MonArr2[@]}"; do
    [ "${MonArr2[j]}" = "$1" ] && return
  done
  return 1
}

if [ "$DISPLAY" ]; then
  N=0
  until [ "$N" -eq 5 ]; do
    ((N += 1))
# Make MonArr1 an array of connected monitors:
    readarray -t MonArr1 < <(xrandr | awk '/ connected /{print $1}')
    for i in "${!MonArr1[@]}"; do
      if [ "${MonArr1[i]}" = DP-1 ]; then
# Make MonArr2 an array of active monitors:
        readarray -t MonArr2 < <(xrandr --listactivemonitors | awk 'FNR >1 {print $4}')
        if chk_monitor DP-1; then
          if chk_monitor eDP-1; then
            xrandr --output DP-1 --mode 2560x1440 --output eDP-1 --off
          else
            xrandr --output eDP-1 --auto --output DP-1 --off
          fi
        else
          xrandr --output eDP-1 --auto --output DP-1 --mode 2560x1440 --right-of eDP-1
        fi
        exit
      fi
    done
    sleep 1
  done
  printf '%s\n' "Monitor DP-1 not found!" >&2
  exit 1
fi
