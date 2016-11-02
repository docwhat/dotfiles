#!/bin/bash

set -euo pipefail

typeset -ar terms=(
dumb
linux

xterm
xtermc
xterm-color
xterm-256color

screen
screen-256color
screen.xterm-new

tmux
tmux-256color
)

has_italics() {
  local term="$1"
  infocmp -1IL "$term" | grep -q _italics_mode
}

backspace_char() {
  local term="$1"
  infocmp -1IL "$term" | perl -n -e 'print "$1\n" if m/^\s*key_backspace=([^,]+)/;'
}

for term in "${terms[@]}"; do
  v=notchecked
  if env "TERM=$term" tput cols >/dev/null 2>&1; then
    v="✔"
    if has_italics "$term"; then
      v="${v} i"
    else
      v="${v}  "
    fi
    v="${v} $(backspace_char "$term")"
  else
    v="𐄂"
  fi
  printf "TERM=%-20s %s\n" "$term" "$v"
done

# EOF
