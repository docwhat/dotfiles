
if (( ${+commands[pyenv]} )); then
  mkdir -p "$PYENV_ROOT"
  eval "$(pyenv init - --no-rehash zsh)"

  if [[ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]]; then
    eval "$(pyenv virtualenv-init - )"
  fi

  add-rehash-hook command pyenv rehash
else
  echo "Use pyenv-install to install python..."
  echo "    curl https://pyenv.run | bash"
fi

