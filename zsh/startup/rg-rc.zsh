

#!zsh

if (( ${+commands[rg]} )); then
  (
    setopt extendedglob

    if ! [[ -e ~/.zsh/functions/_rg(#qN.mh+24) ]]; then
      {
        command rg --generate=complete-zsh > ~/.zsh/functions/_rg
      } &!
    fi

    if ! [[ -e "${XDG_DATA_HOME}/man/man1/rg.1"(#qN.mh+24) ]]; then
      {
        rm -f "${XDG_DATA_HOME}/man/man1/rg.1"
        command rg --generate=man > "${XDG_DATA_HOME}/man/man1/rg.1"
      } &!
    fi
  )
fi
