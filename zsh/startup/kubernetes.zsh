#!zsh

autoload -U is-at-least

if is-at-least 5.2; then
  # Get kubectl completion
  if (( $+commands[kubectl] )); then
    {
      source <(kubectl completion zsh)
      alias k=kubectl
      complete -F __start_kubectl k
    } &!
  fi

  if (( $+commands[tkn] )); then
    {
      source <(tkn completion zsh)
    } &!
  fi

  if (( $+commands[helm] )); then
    {
      source <(helm completion zsh)
    } &!
  fi
fi