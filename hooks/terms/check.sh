#!/bin/bash

typeset -a term=(
  xterm
  xtermc
  xterm-color
  xterm-256color
  screen
  screen-256color
  screen.xterm-new
  tmux18-256color
)

for term in "${term[@]}"; do
  env "TERM=$term" tput cols >/dev/null 2>/dev/null && echo "TERM=$term"
done

# EOF
