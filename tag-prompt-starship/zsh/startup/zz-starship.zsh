zinit ice from"gh-r" as"program"
zinit light starship/starship

if (( $+commands[starship] )); then
  starship completions zsh > ~/.zsh/functions/_starship &!
  eval "$(starship init zsh)"
fi
