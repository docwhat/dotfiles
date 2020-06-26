#!zsh

autoload -U is-at-least

# Keep the configs secure.
if ! [[ -d ~/.kube/config.d ]]; then
  mkdir -m 0700 -p ~/.kube/config.d
fi

if [[ -f ~/.kube/config ]]; then
  chmod 0600 ~/.kube/config
fi

if is-at-least 5.2; then
  # Get kubectl completion
  if (( $+commands[kubectl] )) && \
    [[ -n ~/.zsh/functions/_kubectl(#qN.mh+24) ]]; then
      {
      env KUBECONFIG= \
        kubectl completion zsh \
        > ~/.zsh/functions/_kubectl
      } &!
  fi

  if (( $+commands[tkn] )) && \
    [[ -n ~/.zsh/functions/_tkn(#qN.mh+24) ]]; then
      {
        tkn completion zsh \
        > ~/.zsh/functions/_tkn
      } &!
  fi

  if (( $+commands[helm] )) && \
    [[ -n ~/.zsh/functions/_helm(#qN.mh+24) ]]; then
      {
        helm completion zsh \
        > ~/.zsh/functions/_helm
      } &!
  fi
fi
