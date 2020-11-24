zinit ice from"gh-r" as"program"
zinit light starship/starship

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi
