#!/bin/bash

set -euo pipefail

is_osx() {
  local platform=$(uname)
  [ "$platform" == "Darwin" ]
}

# Figure out the SHORT hostname
if is_osx; then
  short_host=$(scutil --get ComputerName)
  short_host="${short_host%% \(*\)}"
else
  short_host=$(hostname)
  short_host=${short_host/.*/}
fi

short_host_size=${#short_host}
session_name=$(tmux display-message -p '#S' || echo 6)
session_name_length=${#session_name}

tmux set-option -g status-attr dim
tmux set-option -g status-justify centre # center spelled funny
tmux set-option -g status-style "fg=colour235,bg=colour235,none"

tmux set-option -g pane-border-style "fg=colour238"
tmux set-option -g pane-border-style "fg=colour27"

tmux set-option -g status-left-length $(( short_host_size + 4 ))
tmux set-option -g status-left-style "none"
tmux set-option -g status-left "#{prefix_highlight}#[fg=colour232,bg=colour154] $short_host #[fg=colour154,bg=colour235,nobold,nounderscore,noitalics]#[default]"

tmux set-option -g status-right-length $(( session_name_length + 37 ))
tmux set-option -g status-left-style "none"
tmux set-option -g status-right "#[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour154,bg=colour238] %Y-%m-%d  %l:%M%P #[fg=colour154,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour232,bg=colour154] #S "

# Message popup.
tmux set-option -g message-command-style "fg=colour222,bg=colour238"
tmux set-option -g message-style "fg=colour222,bg=colour27"

tmux set-window-option -g mode-style fg='#dddddd',bg='#2222ee'
tmux set-window-option -g window-status-activity-attr "none"
tmux set-window-option -g window-status-activity-style "fg=colour154,bg=colour235,none"
tmux set-window-option -g window-status-separator ""
tmux set-window-option -g window-status-style "fg=colour121,bg=colour235,none"
tmux set-window-option -g window-status-format "#[fg=colour121,bg=colour235] #I  #W#F"
tmux set-window-option -g window-status-current-format "#[fg=colour235,bg=colour154,nobold,nounderscore,noitalics]#[fg=colour238,bg=colour154] #I  #W#F#[fg=colour154,bg=colour235,nobold,nounderscore,noitalics]"

# EOF
