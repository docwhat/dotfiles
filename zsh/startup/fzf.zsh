
if [ -d "$fzf_base_dir" ]; then
  # Enable FZF via TMUX pane
  if [ -n "$TMUX" ]; then
    FZF_TMUX=1
  fi

  if [ -d '/usr/local/opt/fzf/shell' ]; then
    source '/usr/local/opt/fzf/shell/completion.zsh'
    source '/usr/local/opt/fzf/shell/key-bindings.zsh'
  fi
fi
