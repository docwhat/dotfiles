# Get kubectl completion
if (( $+commands[kubectl] )) && [ -x "${commands[kubectl]}" ] && is-at-least 5.2; then
  {
    source <(kubectl completion zsh)
  } &!
fi
