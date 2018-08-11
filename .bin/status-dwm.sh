#!/bin/bash

Date="$(date +"%-l:%M %P %a %b %-d %Y")"
External_IP="$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null)"
Internal_IP="$(hostname -i | awk '{print $1}' | grep 192)"
ISP_IP="$(hostname -i | awk '{print $2}')"
if [ "$Internal_IP" ]; then
  if [ "$External_IP" ]; then
    xsetroot -name " $Internal_IP · $External_IP · $Date"
  elif [ "$ISP_IP" ]; then
    xsetroot -name " $Internal_IP · $ISP_IP · $Date"
  else
    xsetroot -name " $Internal_IP · $Date"
  fi
else
  xsetroot -name " $Date"
fi
