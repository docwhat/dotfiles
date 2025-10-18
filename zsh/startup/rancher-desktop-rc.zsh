#!zsh

(
  autoload -U is-at-least
  setopt extended_glob

  if is-at-least 5.2; then
    if (( ${+commands[nerdctl]} )) && \
      ! [[ -e ~/.zsh/functions/_nerdctl(#qN.mh+24) ]]; then
        {
          nerdctl completion zsh \
          > ~/.zsh/functions/_nerdctl
        } &!
    fi

    if (( ${+commands[rdctl]} )) && \
      ! [[ -e ~/.zsh/functions/_rdctl(#qN.mh+24) ]]; then
        {
          rdctl completion zsh \
          > ~/.zsh/functions/_rdctl
        } &!
    fi
  fi
)
