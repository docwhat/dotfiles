#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

tmux_version="$(tmux -V | cut -d ' ' -f 2)"
tmux_is_at_least() {
  if [[ $tmux_version == "$1" ]]; then
    return 0
  fi

  local IFS=.
  local i tver=($tmux_version) wver=($1)

  # fill empty fields in tver with zeros
  for ((i = ${#tver[@]}; i < ${#wver[@]}; i++)); do
    tver[i]=0
  done

  # fill empty fields in wver with zeros
  for ((i = ${#wver[@]}; i < ${#tver[@]}; i++)); do
    wver[i]=0
  done

  for ((i = 0; i < ${#tver[@]}; i++)); do
    if ((10#${tver[i]} < 10#${wver[i]})); then
      return 1
    fi
  done
  return 0
}

if tmux_is_at_least 2.4; then
  # shellcheck source=tmux/2.4.sh
  source './2.4.sh'
elif tmux_is_at_least 1.9; then
  # shellcheck source=tmux/1.9.sh
  source './1.9.sh'
fi

## Common configurations

# Use SSH-Agent OMZ plugin ###
tmux set-option -g update-environment "DISPLAY WINDOWID SSH_ASKPASS SSH_AGENT_PID SSH_CONNECTION TERM"
tmux set-environment -g "SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"

# EOF
