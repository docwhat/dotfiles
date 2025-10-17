#!zsh

(
  setopt extendedglob

  if (( ${+commands[container]} )) && \
    [[ -n ~/.zsh/functions/_container(#qN.mh+24) ]]; then
      {
        container --generate-completion-script zsh \
        > ~/.zsh/functions/_container
      } &!
  fi
)
