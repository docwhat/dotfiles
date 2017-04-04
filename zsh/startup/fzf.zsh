
if [ -d ~/.fzf ]; then
  export FZF_DEFAULT_OPTS='
  --color fg:#e8e8d3,bg:-1,hl:#ff8800,fg+:-1,bg+:#404040,hl+:#ffff00
  --color info:#ddaaff,prompt:#88aadd,spinner:#88aa55,pointer:#dd5555,marker:#ffaa55
  '

  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --inline-info --bind=ctrl-k:kill-line"

  export FZF_CTRL_R_OPTS="--with-nth=2.. --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard'"

  # Enable FZF via TMUX pane
  if [ -n "$TMUX" ]; then
    export FZF_TMUX=1
  else
    export FZF_CTRL_R_OPTS="${FZF_CTRL_R_OPTS} --border"
  fi

  source ~/.fzf/shell/completion.zsh
  source ~/.fzf/shell/key-bindings.zsh

  export FZF_COMPLETION_TRIGGER=''
  bindkey '^T' fzf-completion
  bindkey '^I' $fzf_default_completion

  #   - CTRL-O to open with `open` command,
  #   - CTRL-E or Enter key to open with the $EDITOR
  function fe {
    local out file key
    local ed="${EDITOR:-vim}"
    IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e --header "Press CTRL-O to use open, Enter or CTRL-E to use ${ed}"))
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
      if [ "$key" = ctrl-o ]; then
        echo "Opening $file" 1>&2
        open "$file"
      else
        ${ed} "$file"
      fi
    fi
  }

  manpath=( "${manpath[@]}" ~/.fzf/man )
fi
