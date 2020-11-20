if (( ${+commands[pyenv]} )); then
  add-rehash-hook command pyenv rehash
  eval "$(pyenv init - --no-rehash zsh)"
fi
