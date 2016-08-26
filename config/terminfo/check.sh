#!/bin/bash

typeset -a term=(
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

for term in "${term[@]}"; do
  v=notchecked
  if env "TERM=$term" tput cols >/dev/null 2>&1; then
    v=ok
  else
    v=missing
  fi
  printf "TERM=%-20s %s\n" "$term" "$v"
done

# EOF
