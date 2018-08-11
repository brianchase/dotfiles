#!/bin/bash

sleep 1s
xset dpms force off && [ -x "$(command -v slock)" ] && slock
