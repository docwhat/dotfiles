(
  setopt extendedglob

  if (( ${+commands[cline]} )) && \
    ! [[ -e ~/.zsh/functions/_cline(#qN.mh+24) ]]; then
      {
        cline completion zsh > ~/.zsh/functions/_cline
      } &!
  fi
)
