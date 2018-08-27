#!/bin/bash

comp_files () {
  if [ -z "$1" ]; then
    ME="$(basename "$0")"
    comp_error "Usage: $ME [input file]"
  elif [ ! -r "$1" ]; then
    comp_error "'$1' is not readable!"
  elif [ ! "$(file --mime-type -b "$1")" = text/x-tex ]; then
    comp_error "'$1' is not a TeX file!"
  fi
  case $1 in
    *.[tT][eE][xX]) Out="${1/%[tT][eE][xX]/pdf}" ;;
    *) Out="$1.pdf" ;;
  esac
}

comp_error () {
  printf '%s\n' "$1" >&2
  exit 1
}

comp_pdf () {
  if [ -x "$(command -v zathura)" ]; then
    read -r -p "Open '$Out'? [y/n] " Open
    [ "$Open" = y ] && zathura "$Out"
  else
    printf '%s\n' "Please see '$Out'"
  fi
}

comp_tex () {
  latexmk -C
  if head -n 5 "$1" | grep -iq 'powerdot'; then
    if ! latexmk -bibtex -f -pdfps -silent "$1"; then
      comp_error "Please see log for errors!"
    fi
  else
#    if ! xelatex --interaction=nonstopmode "$1"; then
    if ! latexmk -bibtex -f -xelatex -silent "$1"; then
      comp_error "Please see log for errors!"
    fi
  fi
  printf '\n%s' "Done! "
  comp_pdf
}

comp_files "$1" && comp_tex "$1"
