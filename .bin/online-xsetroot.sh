#!/bin/bash

# online-netctl.sh: https://github.com/brianchase/online-netctl
# status-dwm.sh: https://github.com/brianchase/dotfiles/.bin

if [ -x "$(command -v online-netctl.sh)" ] && [ -x "$(command -v status-dwm.sh)" ]; then
  online-netctl.sh && status-dwm.sh
fi
