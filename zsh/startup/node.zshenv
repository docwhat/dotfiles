# vim:set ft=zsh:

PREFERRED_NODE=10
if [[ -d "/usr/local/opt/node@${PREFERRED_NODE}/bin" ]]; then
  path=( "/usr/local/opt/node@${PREFERRED_NODE}/bin" "${path[@]}" )
fi

for p in "${HOME}/.yarn/bin" "${HOME}/.config/yarn/global/node_modules/.bin"; do
  if [[ -d "$p"(:h) ]]; then
    path=( "$p" "${path[@]}" )
  fi
done
