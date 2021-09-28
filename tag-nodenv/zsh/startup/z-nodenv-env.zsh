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

  path+="$NODENV_ROOT/bin"
fi
