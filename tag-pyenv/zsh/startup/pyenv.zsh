if [ "${ZSH_ENABLEPYTHON}" != false ]; then
  if (( $+commands[pyenv] )) && [ -d "${PYENV_ROOT}" ]; then
    # Only run pyenv rehash if it was run over 5 minutes ago.
    for i in "${PYENV_ROOT}/shims"(/Nmm+5); do
      touch "${PYENV_ROOT}/shims"
      {
        pyenv rehash
      } &!
    done

    function pyenv_rehash { pyenv rehash }
    custom_rehash_hooks=( pyenv_rehash "${custom_rehash_hooks[@]}" )
  fi
fi
