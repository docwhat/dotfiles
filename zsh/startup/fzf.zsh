
if [ -d ~/.fzf ]; then
  # Enable FZF via TMUX pane
  if [ -n "$TMUX" ]; then
    FZF_TMUX=1
  fi

  source ~/.fzf/shell/completion.zsh
  source ~/.fzf/shell/key-bindings.zsh

  manpath=( "${manpath[@]}" ~/.fzf/man )
fi
