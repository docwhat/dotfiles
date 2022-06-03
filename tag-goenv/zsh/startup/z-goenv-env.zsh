#!/bin/zsh
# vi: ft=zsh :

if [ "$ZSH_ENABLEGO" != false ]; then
  export GOENV_ROOT="${GOENV_ROOT:-${XDG_DATA_HOME}/goenv}"

  export GOENV_SHELL=zsh

  export GOENV_VIRTUALENV_DISABLE_PROMPT=1

  path+=("${GOENV_ROOT}/bin")
fi

# EOF
