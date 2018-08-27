#!/bin/bash

snip_files () {
  if [ -z "$1" ]; then
    ME="$(basename "$0")"
    snip_error "Usage: $ME [input file] [output file]"
  elif [ ! -r "$1" ]; then
    snip_error "'$1' is not readable!"
#  elif [ ! "$(file --mime-type -b "$1")" = application/pdf ]; then
  elif [ ! "$(head -c 4 "$1")" = %PDF ]; then
    snip_error "'$1' is not a PDF!"
  fi
  In="$1"
  Out="${2:-output.pdf}"
  case $Out in
    *.pdf) ;; # Skip the substitution below:
    *.[pP][dD][fF]) Out="${Out/%[pP][dD][fF]/pdf}" ;;
    *) Out="$Out.pdf" ;;
  esac
}

snip_commands () {
  if ! [ -x "$(command -v qpdf)" ] && ! [ -x "$(command -v gs)" ]; then
    snip_error "No command for extracting pages!"
  fi
}

snip_total () {
  if [ -x "$(command -v qpdf)" ]; then
    Total="$(qpdf --show-npages "$In")"
  else
    Total="$(gs -q -dNODISPLAY -c "($In) (r) file runpdfbegin pdfpagecount = quit")"
  fi
  printf '%s\n' "Total pages in '$In': $Total"
}

snip_answers () {
  case $1 in
    ''|*[!0-9]*) return 1 ;;
  esac
  if [ "$1" -eq 0 ]; then
    printf '%s\n' "Page number cannot be less than 1!" >&2
    return 1
  elif [ "$1" -gt "$Total" ]; then
    printf '%s\n' "Page number cannot be more than $Total!" >&2
    return 1
  elif [ "$Last" ] && [ "$Last" -lt "$First" ]; then
    printf '%s\n' "Page number cannot be less than $First!" >&2
    return 1
  fi
}

snip_queries () {
  while true; do
    read -r -p "Number of first page to extract: " First
    snip_answers "$First" && break
  done
  if [ "$Total" ] && [ "$First" -eq "$Total" ]; then
    Last="$First"
    printf '%s\n' "Number of last page to extract: $Last"
  else
    while true; do
      read -r -p "Number of last page to extract: " Last
      snip_answers "$Last" && break
    done
  fi
}

snip_error () {
  printf '%s\n' "$1" >&2
  exit 1
}

snip_pages () {
  if [ -x "$(command -v qpdf)" ]; then
    if ! qpdf "$In" --pages "$In" "$First"-"$Last" -- "$Out"; then
      snip_error "Failed to extract pages!"
    fi
  else
    if ! gs -q -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage="$First" -dLastPage="$Last" -sOutputFile="$Out" "$In"; then
      snip_error "Failed to extract pages!"
    fi
  fi
  printf '%s\n' "Done! Please see '$Out'"
}

snip_main () {
  snip_files "$1" "$2"
  snip_commands
  snip_total
  snip_queries
  snip_pages
}

snip_main "$1" "$2"
