#!/bin/bash

# vpn-client.sh: https://github.com/brianchase/vpn-client
# status-dwm.sh: https://github.com/brianchase/dotfiles/.bin

if [ -x "$(command -v vpn-client.sh)" ] && [ -x "$(command -v status-dwm.sh)" ]; then
  vpn-client.sh "$1" "$2" && sleep 2 && status-dwm.sh
fi
