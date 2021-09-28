if (( ${+commands[kitty]} )); then
  mkdir -p ~/.cache/kitty

  autoload -Uz compinit
  compinit
  kitty +complete setup zsh | source /dev/stdin

  if [[ -n $KITTY_WINDOW_ID ]]; then
    icat() {
      kitty + icat "$@"
    }
  fi
fi
