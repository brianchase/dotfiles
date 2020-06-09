#!/bin/bash

# Change as necessary:
Config="/etc/wpa_supplicant/wpa_supplicant.conf"
Interface="wlp3s0"
VPN="y"

net_sudo () {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

net_error () {
  printf '%s\n' "$1" >&2
  exit 1
}

external_ip () {
  local External_IP
  External_IP="$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null)"
  [ "$External_IP" ] || net_error "External address not found!"
  printf '%s\n' "External address: $External_IP"
}

net_terminate () {
  wpa_cli -i "$Interface" terminate &>/dev/null
  [ "$1" = noerror ] && return
  net_error "$1"
}

vpn_arg () {
  if [ -x "$(command -v client-openvpn.sh)" ]; then
    if [ "$1" = start ]; then
      if [ "$VPN" != y ]; then
        read -r -p "Start an OpenVPN client? [y/n] " VPN
      fi
      if [ "$VPN" = y ]; then
        if client-openvpn.sh start now; then
          sleep 3
          external_ip
        fi
      fi
    else
      client-openvpn.sh "$1" now
    fi
  fi
}

net_main () {
  local Close Internal_IP Open SSID
  if wpa_cli -i "$Interface" status &>/dev/null; then
    read -r -p "Close connection on interface $Interface? [y/n] " Close
    if [ "$Close" = "y" ]; then
      vpn_arg stop
      net_terminate noerror
      net_sudo dhcpcd -k "$Interface" -q 2>/dev/null
    fi
  elif [ ! -s "$Config" ] || [ ! -r "$Config" ]; then
    net_error "$Config is missing, unreadable, or empty!"
  else
    read -r -p "Open connection on interface $Interface? [y/n] " Open
    if [ "$Open" = "y" ]; then
      printf '%s\n' "Connecting on interface $Interface..."
      vpn_arg stop
      if [ "$(find /run/dhcpcd/$Interface*.pid 2>/dev/null)" ]; then
        wpa_cli -i "$Interface" terminate &>/dev/null
        net_sudo dhcpcd -k "$Interface" -q 2>/dev/null
      fi
      net_sudo wpa_supplicant -B -c "$Config" -i "$Interface" -q || net_terminate
# Not all errors from dhcpcd here mean no connection. Wait, then check.
      net_sudo dhcpcd -q "$Interface" || sleep 12
      Internal_IP="$(ip addr show "$Interface" | grep -oP 'inet \K[^ /]*')"
      if [ "$Internal_IP" ]; then
        SSID="$(wpa_cli -i "$Interface" status | grep -oP '^ssid=\K[^ ]*')"
        printf '%s\n' "Internal address: $Internal_IP on $SSID"
        external_ip
        vpn_arg start
      else
        net_terminate "Failed to get an IP address!"
      fi
    fi
  fi
}

net_main
