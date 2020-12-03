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
fi
