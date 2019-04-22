#!/bin/bash

set -euo pipefail

# My favorite prefix.
tmux unbind C-b
tmux set-option -g prefix '`'
tmux bind-key -r '`' send-prefix

# Use vi keys except for status line.
tmux set-window-option -g mode-keys vi
tmux set-option -g status-keys "emacs"

# # Window movement without prefix
# tmux bind-key -n C-h select-pane -L
# tmux bind-key -n C-j select-pane -D
# tmux bind-key -n C-k select-pane -U
# tmux bind-key -n C-l select-pane -R

tmux bind-key -r k select-pane -U
tmux bind-key -r j select-pane -D
tmux bind-key -r h select-pane -L
tmux bind-key -r l select-pane -R

tmux bind-key '|' split-window -h
tmux bind-key '-' split-window -v

# Zoom
tmux bind-key -n C-Space resize-pane -Z

# Use SSH-Agent OMZ plugin ###
tmux set-option -g update-environment "DISPLAY WINDOWID SSH_ASKPASS SSH_AGENT_PID SSH_CONNECTION TERM"
tmux set-environment -g "SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"

tmux set-option -g renumber-windows on

# EOF
