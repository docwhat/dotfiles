if [ -n "$TMUX" ]; then

  # Returns the arguments to pass to tmux set-window-option to restore
  # a setting.
  get_tmux_window_option() {
    local arg_name=$1
    local value="$(tmux show-window-option ${arg_name})"
    if [ -z "$value" ]; then
      value="-u ${(q)arg_name}"
    fi
    echo "tmux set-window-option ${value}"
  }

  # Alias so ssh will change the window name.
  ssh() {
    local old_name="$(tmux display-message -p '#{window_name}')"
    local reset_eval="$(get_tmux_window_option automatic-rename) ; $(get_tmux_window_option allow-rename)"
    tmux rename-window "ssh/$*"
    command ssh "$@"
    local ec=$?
    tmux rename-window "${old_name}"
    eval "${reset_eval}"
    return $ec
  }
fi
