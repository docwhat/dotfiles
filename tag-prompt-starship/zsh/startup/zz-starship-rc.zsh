
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

  if (( ${+commands[kitty]} )) && [[ -n $KITTY_WINDOW_ID ]]; then
    function docwhat-pretty-dir() {
      # strip color and trailing space
      starship module directory | sed $'s/\e\[[0-9;]*m//g; s/ $//g'
    }

    function docwhat-starship-precmd() {
      if [[ -n "$KITTY_WINDOW_ID" ]]; then
        kitty @ set-tab-title "--match=window_id:$KITTY_WINDOW_ID" "$(docwhat-pretty-dir)"
      fi
    }
    precmd_functions+=(docwhat-starship-precmd)

    function docwhat-starship-preexec() {
      if [[ -n "$KITTY_WINDOW_ID" ]]; then
        kitty @ set-tab-title "--match=window_id:$KITTY_WINDOW_ID" "$1"
      fi
    }
    preexec_functions+=(docwhat-starship-preexec)
  fi

  declare -Ua preexec_functions precmd_functions
fi
