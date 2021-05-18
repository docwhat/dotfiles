
if (( ${+commands[goenv]} )); then
  mkdir -p "$GOENV_ROOT"
  eval "$(goenv init - --no-rehash zsh)"

  add-rehash-hook command goenv rehash
fi

