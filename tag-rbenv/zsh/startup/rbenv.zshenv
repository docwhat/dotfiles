# vim: ft=zsh :

if [ -x "${RBENV_ROOT}/bin/rbenv" ]; then
  export PATH="${HOME}/bin:${PATH}:${RBENV_ROOT}/bin"
fi

if (( $+commands[rbenv] )) && [ -d "${RBENV_ROOT}" ]; then
  eval "$(rbenv init - --no-rehash)"
  # rbenv init - is being too clever by half... Fix the
  # path ourselves.
  export PATH="${HOME}/bin:${RBENV_ROOT}/shims:${PATH}"
fi
