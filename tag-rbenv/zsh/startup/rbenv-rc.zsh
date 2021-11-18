if (( ${+commands[rbenv]} )); then
  mkdir -p "$RBENV_ROOT"

  eval "$(rbenv init - --no-rehash zsh)"

  add-rehash-hook command rbenv rehash
else
  echo "Use rbenv-install to install ruby..."
  echo "    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash"
fi
