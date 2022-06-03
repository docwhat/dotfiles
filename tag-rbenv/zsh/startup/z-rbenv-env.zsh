# vi: ft=zsh :

if [ "$ZSH_ENABLERUBY" != false ]; then
  export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"

  export RBENV_SHELL=zsh

  path+=("${RBENV_ROOT}/bin")
fi
