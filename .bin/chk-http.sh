#!/bin/bash

for i in $(ls -I lo /sys/class/net/); do
  if [ "$(cat /sys/class/net/$i/carrier 2>/dev/null)" = 1 ]; then
    Net="1"
    break
  fi
done
if [ -z "$Net" ]; then
  if [ -x "$(command -v online-iwd.sh)" ]; then
    if online-iwd.sh; then
      [ -x "$(command -v status-dwm.sh)" ] && status-dwm.sh
      exit
    fi
  fi
  printf '%s\n' "Not online!" >&2
  exit 1
elif ! ping -q -w1 -c1 8.8.8.8 &>/dev/null; then
  printf '%s\n' "LAN connection only!" >&2
  exit 1
fi
