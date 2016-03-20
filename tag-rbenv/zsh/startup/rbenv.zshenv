# vim: ft=zsh :

if [ "${ZSH_ENABLERUBY}" != false ]; then
  if [ -x "${RBENV_ROOT}/bin/rbenv" ]; then
    export PATH="${HOME}/bin:${PATH}:${RBENV_ROOT}/bin"
  fi

  if (( $+commands[rbenv] )) && [ -d "${RBENV_ROOT}" ]; then
    p="$PATH"
    eval "$(rbenv init - --no-rehash zsh)"
    # rbenv init - is being too clever by half... Fix the
    # path ourselves.
    export PATH="${HOME}/bin:${RBENV_ROOT}/shims:${p}"
    unset p
  fi
fi
