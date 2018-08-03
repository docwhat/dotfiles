# vim:set ft=zsh:

for p in "${HOME}/.yarn/bin" "${HOME}/.config/yarn/global/node_modules/.bin"; do
  if [ -d "$(dirname "$p")" ]; then
    path=( "$p" "${path[@]}" )
  fi
done
