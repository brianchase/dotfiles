#!/bin/bash

# Change as necessary:
Config="/etc/wpa_supplicant/wpa_supplicant.conf"
Interface="wlan0"

wpa_sudo () {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

wpa_error () {
  printf '%s\n' "$1" >&2
  exit 1
}

wpa_terminate () {
  wpa_cli -i "$Interface" terminate &>/dev/null
  [ "$1" = noerror ] && return
  wpa_error "$1"
}

wpa_main () {
  local Close Internal_IP Open SSID
  if wpa_cli -i "$Interface" status &>/dev/null; then
    read -r -p "Close connection on interface $Interface? [y/n] " Close
    if [ "$Close" = "y" ]; then
      if [ -x "$(command -v online-vpn.sh)" ]; then
        source online-vpn.sh
        vpn_stop "$1"
      fi
      wpa_terminate noerror
      sleep 1
      wpa_sudo dhcpcd -k "$Interface" -q
    fi
  elif [ ! -s "$Config" ] || [ ! -r "$Config" ]; then
    wpa_error "$Config is missing, unreadable, or empty!"
  else
    read -r -p "Open connection on interface $Interface? [y/n] " Open
    if [ "$Open" = "y" ]; then
      if [ -x "$(command -v online-vpn.sh)" ]; then
        source online-vpn.sh
        vpn_resolv || wpa_error "Check resolv.conf!"
      fi
      printf '%s\n' "Connecting on interface $Interface..."
      if [ -f "/run/dhcpcd/$Interface.pid" ]; then
        wpa_cli -i "$Interface" terminate &>/dev/null
        wpa_sudo dhcpcd -k "$Interface"
      fi
      wpa_sudo wpa_supplicant -B -c "$Config" -i "$Interface" -q || wpa_terminate
# Not all errors from dhcpcd here mean no connection. Wait, then check.
      wpa_sudo dhcpcd -q "$Interface" || sleep 12
      Internal_IP="$(ip addr show "$Interface" | grep -oP 'inet \K[^ /]*')"
      if [ "$Internal_IP" ]; then
        SSID="$(wpa_cli -i "$Interface" status | grep -oP '^ssid=\K[^ ]*')"
        printf '%s\n' "LAN address: $Internal_IP on $SSID"
        if [ -x "$(command -v online-vpn.sh)" ]; then
          external_ip ISP
          vpn_start "$1"
        fi
      else
        wpa_terminate "Failed to get a LAN address!"
      fi
    fi
  fi
}

wpa_main "$1"
