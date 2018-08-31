#!/bin/bash

pacman_syu () {
  if [ "$(id -u)" -eq 0 ]; then
    pacman -Syu
  elif [ "$(sudo -l | grep -o pacman)" ]; then
    sudo pacman -Syu
  else
    printf '%s\n' "Not authorized to run pacman!" >&2
    exit 1
  fi
}

pacman_rns () {
  if [ "$(pacman -Qdqt)" ]; then
    local Remove
    read -r -p "Remove orphans? [y/n] " Remove
    if [ "$Remove" = y ] && [ "$(id -u)" -eq 0 ]; then
      pacman -Rns $(pacman -Qdqt)
    elif  [ "$Remove" = y ]; then
      sudo pacman -Rns $(pacman -Qdqt)
    fi
  fi
}

pacman_syu && pacman_rns
