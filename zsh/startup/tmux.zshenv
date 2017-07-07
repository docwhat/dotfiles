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

  tmux_rename_window_for_command() {
    local name="$1" ; shift
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

    {
      tmux rename-window -t "${wid}" "$name"
      "$@"
    } always
    {
      tmux rename-window -t "${wid}" "${old_name}"
      eval "${reset_eval}"
    }
  }

  tmux_ssh() {
    local c=' '
    tmux_rename_window_for_command "${c}$1" command ssh "$@"
  }
  alias ssh=tmux_ssh

  tmux_mosh() {
    local c=' '
    tmux_rename_window_for_command "${c}$1" command mosh "$@"
  }
  alias mosh=tmux_mosh
fi
