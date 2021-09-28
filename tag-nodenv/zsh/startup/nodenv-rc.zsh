if (( ${+commands[nodenv]} )); then
  add-rehash-hook command nodenv rehash
  eval "$(nodenv init - --no-rehash zsh)"
fi
