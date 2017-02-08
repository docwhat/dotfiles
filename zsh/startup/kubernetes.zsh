# Get kubectl completion
if (( $+commands[kubectl] )) && is-at-least 5.2; then
  source <(kubectl completion zsh)
fi
