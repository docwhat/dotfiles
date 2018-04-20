# vi: ft=zsh :

if [ "${ZSH_ENABLERUBY}" != false ]; then

  ## Set the RBENV root directory
  if [ -r ~/.config/personal/rbenv-root ]; then
    RBENV_ROOT=$(cat ~/.config/personal/rbenv-root)
  else
    RBENV_ROOT="${HOME}/.rbenv"
    # Save it for future use.
    echo "$RBENV_ROOT" > ~/.config/personal/rbenv-root
  fi
  export RBENV_ROOT

  ## Set the shell for RBENV
  RBENV_SHELL=zsh

  if [ -d "$RBENV_ROOT" ]; then
    if ! (( $+commands[rbenv] )); then
      path+="${RBENV_ROOT}/bin"
    fi

    ## Initialize the RBENV environment.
    if ! (( $+functions[rbenv] )); then
      eval "$(rbenv init - --no-rehash)"
    fi
  fi
fi
