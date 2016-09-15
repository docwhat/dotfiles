if [ -n "$TMUX" ]; then

  # Alias so ssh will change the window name.
  ssh() {
    local old_name="$(tmux display-message -p '#{window_name}')"
    tmux set-window-option automatic-rename off >/dev/null
    tmux set-window-option allow-rename off >/dev/null
    tmux rename-window "ssh/$*"
    command ssh "$@"
    tmux rename-window "${old_name}"
    tmux set-window-option -u allow-rename >/dev/null
    tmux set-window-option -u automatic-rename >/dev/null
  }
fi
