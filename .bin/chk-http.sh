#!/bin/bash

if ! wget -q --tries=10 --timeout=20 --spider http://google.com; then
  if [ -x "$(command -v online-netctl.sh)" ]; then
    if online-netctl.sh; then
       [ -x "$(command -v status-dwm.sh)" ] && status-dwm.sh
       exit
    fi
  fi
  printf '%s\n' "Not online!" >&2
  exit 1
fi
