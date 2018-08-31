#!/bin/bash

if ! wget -q --tries=10 --timeout=20 --spider http://google.com; then
  if [ -x "$(command -v online-netctl.sh)" ]; then
    if [ "$(id -u)" -eq 0 ]; then
      if online-netctl.sh; then
        [ -x "$(command -v status-dwm.sh)" ] && status-dwm.sh
        exit
      fi
    elif [ "$(sudo -l | grep -o online-netctl.sh)" ]; then
      if sudo online-netctl.sh; then
        [ -x "$(command -v status-dwm.sh)" ] && status-dwm.sh
        exit
      fi
    fi
  fi
  printf '%s\n' "Not online!" >&2
  exit 1
fi
