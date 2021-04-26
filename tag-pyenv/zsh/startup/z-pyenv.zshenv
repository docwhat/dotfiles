#!/bin/zsh
# vi: ft=zsh :

if [ "$ZSH_ENABLEPYTHON" != false ]; then
  export PYENV_ROOT="${PYENV_ROOT:-${XDG_DATA_HOME}/pyenv}"

  export PYENV_SHELL=zsh

  path+="${PYENV_ROOT}/bin"
fi

# EOF
