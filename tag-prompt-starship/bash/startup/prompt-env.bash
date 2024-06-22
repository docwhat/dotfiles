#!/usr/bin/env bash

_possible_path="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/plugins/starship"

if ! command -v starship >/dev/null && [[ -x $_possible_path/starship ]]; then
  export PATH="$PATH:$_possible_path"
fi
