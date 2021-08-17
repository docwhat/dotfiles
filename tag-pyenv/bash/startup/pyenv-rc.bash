#!/bin/zsh
# vi: ft=zsh :

if [ "$BASH_ENABLEPYTHON" != false ]; then
  export PYENV_ROOT="${PYENV_ROOT:-${XDG_DATA_HOME}/pyenv}"

  export PYENV_SHELL=zsh

  export PYENV_VIRTUALENV_DISABLE_PROMPT=1

  path+="${PYENV_ROOT}/bin"
fi

if command -v pyenv &>/dev/null; then
  mkdir -p "$PYENV_ROOT"
  eval "$(pyenv init - bash)"

  if [[ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]]; then
    eval "$(pyenv virtualenv-init - )"
  fi
else
  echo "Use pyenv-install to install python..."
  echo "    curl https://pyenv.run | bash"
fi

