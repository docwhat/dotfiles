# vi: ft=zsh :

if [ "${ZSH_ENABLERUBY}" != false ]; then
  if [ -r ~/.config/personal/rbenv-root ]; then
    RBENV_ROOT=$(cat ~/.config/personal/rbenv-root)
  else
    RBENV_ROOT="${HOME}/.rbenv"
    # Save it for future use.
    echo "$RBENV_ROOT" > ~/.config/personal/rbenv-root
  fi

  RBENV_SHELL=zsh
  export RBENV_ROOT RBENV_SHELL

  path=( "${RBENV_ROOT}/shims" "${RBENV_ROOT}/bin" "${path[@]}" )
fi
