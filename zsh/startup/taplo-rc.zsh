#!zsh

(
  setopt extendedglob

  if (( ${+commands[taplo]} )) && \
    ! [[ -e ~/.zsh/functions/_taplo(#qN.mh+24) ]]; then
      {
        taplo completions zsh > ~/.zsh/functions/_taplo
      } &!
  fi
)
