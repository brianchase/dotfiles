#!/bin/bash

# Make MonArr1 an array of connected monitors:
readarray -t MonArr1 < <(xrandr | awk '/ connected /{print $1}')
if [ "${#MonArr1[*]}" -eq 2 ]; then
# Make MonArr2 an array of active monitors:
  readarray -t MonArr2 < <(xrandr --listactivemonitors | awk 'FNR >1 {print $4}')
  if [ "${#MonArr2[*]}" -eq 2 ]; then
    xrandr --output "${MonArr1[1]}" --auto --output "${MonArr1[0]}" --off
  elif [ "${MonArr2[0]}" = "${MonArr1[1]}" ]; then
    xrandr --output "${MonArr1[0]}" --auto --output "${MonArr1[1]}" --off
  else
    xrandr --output "${MonArr1[0]}" --auto --output "${MonArr1[1]}" --auto --right-of "${MonArr1[0]}"
  fi
  [ -x "$(command -v $HOME/.config/feh/fehbg)" ] && $HOME/.config/feh/fehbg
else
  printf '%s\n' "This script needs exactly two connected monitors!" >&2
  exit 1
fi
