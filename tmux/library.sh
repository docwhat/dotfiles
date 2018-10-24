#!/bin/bash

[[ -n $tmux_dir ]] || tmux_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
declare -r tmux_dir
cd "$tmux_dir"

set -euo pipefail

tmux_version="$(tmux -V | cut -d ' ' -f 2)"

function tmux_is_at_least() {
  if [[ $tmux_version == "$1" ]] || [[ $tmux_version == master ]]; then
    return 0
  fi

  local i
  local -a current_version wanted_version
  IFS='.' read -ra current_version <<<"$tmux_version"
  IFS='.' read -ra wanted_version <<<"$1"

  # fill empty fields in current_version with zeros
  for ((i = ${#current_version[@]}; i < ${#wanted_version[@]}; i++)); do
    current_version[i]=0
  done

  # fill empty fields in wanted_version with zeros
  for ((i = ${#wanted_version[@]}; i < ${#current_version[@]}; i++)); do
    wanted_version[i]=0
  done

  for ((i = 0; i < ${#current_version[@]}; i++)); do
    if ((10#${current_version[i]} < 10#${wanted_version[i]})); then
      return 1
    fi
  done
  return 0
}

reverse_array() {
  local -ar original=("$@")
  local -a result=

  for word in "${original[@]}"; do
    result+=("$word")
  done
  echo "${result[@]}"
}
