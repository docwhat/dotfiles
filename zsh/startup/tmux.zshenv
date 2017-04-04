if [ -n "$TMUX" ]; then

  # Returns the arguments to pass to tmux set-window-option to restore
  # a setting.
  get_tmux_window_option() {
    local wid=$1
    local arg_name=$2
    local value="$(tmux show-window-option -t ${(q)wid} ${(q)arg_name})"
    if [ -z "$value" ]; then
      value="-u ${(q)arg_name}"
    fi
    echo "tmux set-window-option -t ${(q)wid} ${value}"
  }

  # Alias so ssh will change the window name.
  tmux_ssh() {
    local wid
    local old_name
    local reset_eval

    if [ -n "$TMUX_PANE" ]; then
      wid="$TMUX_PANE"
    else
      wid="$(tmux display-message -p '#{window_id}')"
    fi
    old_name="$(tmux display-message -t "$TMUX_PANE" -p '#{window_name}')"
    reset_eval="$(get_tmux_window_option ${wid} automatic-rename) ; $(get_tmux_window_option ${wid} allow-rename)"

    tmux rename-window -t "${wid}" "ssh/$*"
    command ssh "$@"
    local ec=$?
    tmux rename-window -t "${wid}" "${old_name}"
    eval "${reset_eval}"
    return $ec
  }
  alias ssh=tmux_ssh
fi
