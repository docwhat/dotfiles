#!/bin/zsh
# vi: ft=zsh :

if [[ ${ZSH_ENABLEPYTHON} != false ]]; then

  ## Set the PYENV root directory
  if [ -r ~/.config/personal/pyenv-root ]; then
    PYENV_ROOT=$(cat ~/.config/personal/pyenv-root)
  else
    PYENV_ROOT="${HOME}/.pyenv"
    # Save it for future use.
    echo "$PYENV_ROOT" >~/.config/personal/pyenv-root
  fi
  export PYENV_ROOT

  ## Set the shell for PYENV
  PYENV_SHELL=zsh

  if [[ -d $PYENV_ROOT ]]; then
    path+="${PYENV_ROOT}/bin"

    ## Initialize the PYENV environment.
    if ! typeset -f pyenv >/dev/null; then
      eval "$(pyenv init - --no-rehash)"
    fi
  else
    # pyenv is not installed.
    unset PYENV_ROOT PYENV_SHELL
  fi
fi
