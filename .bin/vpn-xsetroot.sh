#!/bin/bash

# client-openvpn.sh: https://github.com/brianchase/client-openvpn
# status-dwm.sh: https://github.com/brianchase/dotfiles/.bin

if [ -x "$(command -v vpn-client.sh)" ] && [ -x "$(command -v status-dwm.sh)" ]; then
  client-openvpn.sh "$1" "$2" && sleep 2 && status-dwm.sh
fi
