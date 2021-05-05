# vi: ft=zsh :

if [ "${ZSH_ENABLENODE}" != false ]; then

  ## Set the NODENV root directory
  if [ -r ~/.config/personal/nodenv-root ]; then
    NODENV_ROOT=$(cat ~/.config/personal/nodenv-root)
  else
    NODENV_ROOT="${HOME}/.nodenv"
    # Save it for future use.
    echo "$NODENV_ROOT" >~/.config/personal/nodenv-root
  fi
  export NODENV_ROOT

  ## Set the shell for NODENV
  NODENV_SHELL=zsh

  if [[ -d $NODENV_ROOT ]] && [[ -x "${NODENV_ROOT}/bin/nodenv" ]]; then
    if ! (( ${+commands[nodenv]} )); then
      path+="${NODENV_ROOT}/bin"
    fi
  else
    # nodenv is not installed.
    unset NODENV_ROOT NODENV_SHELL
  fi
fi
