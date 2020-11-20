if (( ${+commands[rbenv]} )); then
  add-rehash-hook command rbenv rehash
  eval "$(rbenv init - --no-rehash zsh)"
fi
