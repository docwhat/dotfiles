if (( $+commands[kitty] )); then
  autoload -Uz compinit
  compinit
  kitty +complete setup zsh | source /dev/stdin
  icat() {
    kitty + icat "$@"
  }
fi
