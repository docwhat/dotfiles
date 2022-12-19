#!/bin/bash

set -euo pipefail

### Keys

tmux bind-key -T copy-mode-vi 'v' send -X begin-selection
tmux bind-key -T copy-mode-vi 'V' send -X select-line
tmux bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle

# Screen kill window.
# unbind k
tmux bind-key k confirm-before kill-window

# Screen style last window
# unbind space
tmux bind-key space last-window

# Zoom
tmux bind-key -n C-Space resize-pane -Z

tmux bind-key S command-prompt -p "fssh: " "new-window 'fssh %1'"
tmux bind-key M command-prompt -p "fmosh: " "new-window 'fmosh %1'"
tmux bind-key c new-window -c "#{?pane_current_path,#{pane_current_path},$HOME}"

# Panes
tmux bind-key -r k select-pane -U \\\; display-pane
tmux bind-key -r j select-pane -D \\\; display-pane
tmux bind-key -r h select-pane -L \\\; display-pane
tmux bind-key -r l select-pane -R \\\; display-pane

tmux bind-key '|' split-window -h -c "#{?pane_current_path,#{pane_current_path},$HOME}" \\\; display-pane
tmux bind-key '-' split-window -v -c "#{?pane_current_path,#{pane_current_path},$HOME}" \\\; display-pane

## Terminal
tmux set-option -g default-terminal tmux-256color
tmux set-option -ga terminal-overrides ",xterm-256color:Tc"

## Titles
tmux set-window -g automatic-rename on
tmux set-window -g allow-rename off

## Enable mouse support (works in iTerm)
tmux set-option -g mouse on

# EOF
