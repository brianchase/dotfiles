#!/bin/bash

if [ "$DISPLAY" ]; then
  Date="$(date +"%-l:%M %P %a %b %-d %Y")"
  LAN_IP="$(hostname -i | awk '{print $1}' | grep 192)"
  if [ -z "$LAN_IP" ]; then
    xsetroot -name " $Date"
  else
    External_IP="$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null)"
    if [ -z "$External_IP" ]; then
      xsetroot -name " $LAN_IP · $Date"
    else
      xsetroot -name " $LAN_IP · $External_IP · $Date"
    fi
  fi
fi
