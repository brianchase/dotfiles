#!/bin/bash

if tmux has-session -t default 2>/dev/null; then
  tmux attach-session -d -t default
else
  tmux new-session -d -s default -n 0
  tmux split-window -h
  tmux split-window -v -p 45
  tmux new-window -n 1
  tmux select-window -t 0
#  tmux selectp -t 0
  tmux attach-session -d -t default
fi
