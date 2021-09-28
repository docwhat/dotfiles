if [[ -d ~/.fzf ]]; then
  source ~/.fzf/shell/completion.zsh
  source ~/.fzf/shell/key-bindings.zsh
  # bindkey '^T' fzf-completion
  # bindkey '^I' $fzf_default_completion

  #   - CTRL-O to open with `open` command,
  #   - CTRL-E or Enter key to open with the $EDITOR
  function fe() {
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

  if (( ${+commands[fd]} )); then
    # Use fd (https://github.com/sharkdp/fd) instead of the default find
    # command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    function _fzf_compgen_path() {
      fd --hidden --follow --exclude ".git" . "$1"
    }

    # Use fd to generate the list for directory completion
    function _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git" . "$1"
    }
  fi

  manpath+=( ~/.fzf/man )
fi
# vim: set ft=zsh :
