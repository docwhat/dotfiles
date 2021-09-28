# vi: ft=zsh :

_zprofile_install_nodenv_plugins() {
  local plugin plugin_dir

  while read plugin; do
    if [[ -z "${plugin//[[:space:]]/}" ]]; then
      continue
    fi

    plugin_dir="${NODENV_ROOT}/plugins/$(basename "$plugin" .git)"
    if ! [[ -d "$plugin_dir" ]]; then
      git clone "https://github.com/${plugin}" "$plugin_dir"
    fi
  done < ~/.config/personal/nodenv-plugins
}

if [ "${ZSH_ENABLENODE}" != false ]; then

  if ! [[ -x "${NODENV_ROOT}/bin/nodenv" ]]; then
    echo "Installing nodenv..."
    git clone "https://github.com/nodenv/nodenv.git"            "${NODENV_ROOT}"
  fi

  _zprofile_install_nodenv_plugins
fi
