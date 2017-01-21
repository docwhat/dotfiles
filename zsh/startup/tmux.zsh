if [ -n "$TMUX" ]; then

  # Returns the arguments to pass to tmux set-window-option to restore
  # a setting.
  get_tmux_window_option() {
    local wid=$1
    local arg_name=$2
    local value="$(tmux show-window-option ${(q)arg_name})"
    if [ -z "$value" ]; then
      value="-u ${(q)arg_name}"
    fi
    echo "tmux set-window-option -t ${(q)wid} ${value}"
  }

  # Alias so ssh will change the window name.
  ssh() {
    local wid="$(tmux display-message -p '#{window_id}')"
    local old_name="$(tmux display-message -p '#{window_name}')"
    local reset_eval="$(get_tmux_window_option ${wid} automatic-rename) ; $(get_tmux_window_option ${wid} allow-rename)"
    tmux rename-window -t "${wid}" "ssh/$*"
    command ssh "$@"
    local ec=$?
    tmux rename-window -t "${wid}" "${old_name}"
    eval "${reset_eval}"
    return $ec
  }
fi
