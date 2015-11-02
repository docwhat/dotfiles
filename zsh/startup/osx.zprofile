# vim: ft=zsh :

if [[ "${OSTYPE}" == darwin* ]]; then
  if [ -x /usr/local/bin/zsh ]; then
    export SHELL=/usr/local/bin/zsh
  fi
fi
