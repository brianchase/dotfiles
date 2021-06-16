#!/bin/bash

Interface="wlan0"

if [ "$DISPLAY" ]; then
  Date="$(date +"%-l:%M %P %a %b %-d %Y")"
  Internal_IP="$(ip addr show "$Interface" | grep -oP 'inet \K[^ /]*')"
  if [ -z "$Internal_IP" ]; then
    xsetroot -name " $Date"
  else
    External_IP="$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null)"
    if [ -z "$External_IP" ]; then
      xsetroot -name " $Internal_IP · $Date"
    else
      xsetroot -name " $Internal_IP · $External_IP · $Date"
    fi
  fi
fi
