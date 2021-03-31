zinit ice \
  --id-as=starship \
  --from=gh-r \
  --as=program \
  --atclone='starship completions zsh > ~/.zsh/functions/_starship' \
  --atpull='%atclone' \
  --atload='!eval $(starship init zsh)'

zinit light starship/starship

if (( ${+commands[starship]} )); then
  eval "$(starship init zsh)"

  if (( ${+commands[kitty]} )); then
    function docwhat-starship-precmd() {
      # strip color and trailing space
      kitty @ set-tab-title "$(starship module directory | sed $'s/\e\[[0-9;]*m//g; s/ $//g')"
    }
    precmd_functions+=(docwhat-starship-precmd)

    function docwhat-starship-preexec() {
      kitty @ set-tab-title "$1"
    }
    preexec_functions+=(docwhat-starship-preexec)
  fi

  declare -Ua preexec_functions precmd_functions
fi
