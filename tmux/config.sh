#!/bin/bash

[ -n "$tmux_dir" ] || tmux_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
declare -r tmux_dir
cd "$tmux_dir"

set -euo pipefail

source './library.sh'

## Common configurations
source './common.sh'

## Version specific configurations

for config in $(reverse_array [1-9]*.sh); do
  version=$(basename "$config" .sh)
  if tmux_is_at_least "$version"; then
    source "$config"
    break
  fi
done

# EOF
