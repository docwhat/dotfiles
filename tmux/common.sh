#!/bin/bash

set -euo pipefail

# My favorite prefix.
tmux set-option -g prefix '`'

# Use SSH-Agent OMZ plugin ###
tmux set-option -g update-environment "DISPLAY WINDOWID SSH_ASKPASS SSH_AGENT_PID SSH_CONNECTION TERM"
tmux set-environment -g "SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"

# EOF
