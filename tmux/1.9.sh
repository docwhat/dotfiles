#!/bin/bash

set -euo pipefail

### Keys

# My favorite prefix.
tmux set-option -g prefix '`'

# Use vi keys
tmux set-window-option -g mode-keys vi

tmux bind-key -t vi-copy 'v'   begin-selection
tmux bind-key -t vi-copy 'V'   select-line
tmux bind-key -t vi-copy 'C-v' rectangle-toggle

# Screen kill window.
# unbind k
tmux bind-key k confirm-before kill-window

# Screen style last window
# unbind space
tmux bind-key space last-window

tmux bind-key S command-prompt -p "fssh: " "new-window 'fssh %1'"
tmux bind-key M command-prompt -p "fmosh: " "new-window 'fmosh %1'"
tmux bind-key c new-window -c "#{?pane_current_path,#{pane_current_path},$HOME}"

## Terminal
tmux set-option -g default-terminal tmux-256color
tmux set-option -ga terminal-overrides ",xterm-256color:Tc"

## Titles
tmux set-window -g automatic-rename on
tmux set-window -g allow-rename off

## Enable mouse support (works in iTerm)
tmux set-option -g mouse on

# EOF
