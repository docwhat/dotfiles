if [ "${ZSH_ENABLERUBY}" != false ]; then
  containsElement () {
    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
    return 1
  }

  if (( $+commands[rbenv] )); then
    if [[ -n "${RBENV_ROOT}" ]]; then
      mkdir -p "${RBENV_ROOT}/cache"
      if [[ -z "$functions[rbenv]" ]]; then
        echo "${fg[red]}Huh... rbenv wasn't loaded in .zshenv?\!${reset_color}" 1>&2
        eval "$(rbenv init - --no-rehash)"
      fi

      # Only run rbenv rehash if it was run over 5 minutes ago.
      for i in "${RBENV_ROOT}/shims"(/Nmm+5); do
        touch "${RBENV_ROOT}/shims"
        (rbenv rehash &)
      done

      function rbenv-update-plugins
      {
        local -a plugins
        plugins=( $(cat "${HOME}/.config/personal/rbenv-plugins") )
        local -a plugin_names

        if ! command -v ruby-build >/dev/null; then
          plugins=( "${plugins[@]}" sstephenson/ruby-build )
        fi

        if [ -d "${RBENV_ROOT}/.git" ]; then
          pushd "${RBENV_ROOT}" > /dev/null
          echo "${fg[blue]}Updating .rbenv${reset_color}"
          if git diff-index --quiet HEAD; then
            git pull --rebase
          else
            echo "   ${fg[red]}skipping -- checkout is dirty${reset_color}"
            git s
          fi
          popd > /dev/null
        fi

        rm -vf "${RBENV_ROOT}/default-gems"

        mkdir -p "${RBENV_ROOT}/plugins"

        for plugin in "${plugins[@]}"; do
          local name=$(basename "${plugin}")
          plugin_names=( "${plugin_names[@]}" "${name}" )
          if [[ -d "${RBENV_ROOT}/plugins/${name}" ]]; then
            pushd "${RBENV_ROOT}/plugins/${name}" > /dev/null
            echo "${fg[blue]}Updating ${plugin}${reset_color}"
            if git diff-index --quiet HEAD; then
              git pull --rebase
            else
              echo "   ${fg[red]}skipping -- checkout is dirty${reset_color}"
              git s
            fi
            popd > /dev/null
          else
            echo "${fg[blue]}Installing ${plugin}${reset_color}"
            hub clone "${plugin}" "${RBENV_ROOT}/plugins/${name}"
          fi
        done

        for other_dir in "${RBENV_ROOT}/plugins/"*(/N); do
          local name=$(basename "${other_dir}")
          if ! containsElement "${name}" "${plugin_names[@]}"; then
            echo "${fg[blue]}Removing ${name}${reset_color}"
            rm -rvf "${RBENV_ROOT}/plugins/${name}"
          fi
        done
      }

      alias rehash="rbenv rehash && rehash"
      alias bi="bundle install --binstubs .bundle/bin"
    else
      echo "Skipping rbenv setup because \$RBENV_ROOT isn't set" 1>&2
    fi
  fi
else
  alias bi="bundle install"
fi
