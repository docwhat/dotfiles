#!/bin/zsh
# vi: ft=zsh :

if [[ "${DOCWHAT_DISABLE_GOENV:-}" == true ]]; then
  path[(r)${GOENV_ROOT}/bin]=()

  unset GOENV_ROOT
  unset GOENV_SHELL
  unset GOENV_VIRTUALENV_DISABLE_PROMPT
  unset GOENV_GOMOD_VERSION_ENABLE
else
  export GOENV_SHELL=zsh
  export GOENV_VIRTUALENV_DISABLE_PROMPT=1

  # Use go.mod's version to select the Go version.
  export GOENV_GOMOD_VERSION_ENABLE=1

  export GOENV_ROOT="${GOENV_ROOT:-${XDG_DATA_HOME}/goenv}"
  path+=("${GOENV_ROOT}/bin")
fi

# EOF
