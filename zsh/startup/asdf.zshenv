if [[ "${OSTYPE}" == darwin*  ]] && [[ -d /usr/local/opt/asdf ]]; then
  export ASDF_DIR=/usr/local/opt/asdf
elif [[ -d ~/.asdf ]]; then
  ASDF_DIR=~/.asdf
fi

# vim: set ft=zsh :
