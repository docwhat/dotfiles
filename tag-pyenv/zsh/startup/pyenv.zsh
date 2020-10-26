if [ "${ZSH_ENABLEPYTHON}" != false ]; then
  if (( $+commands[pyenv] )) && [ -d "${PYENV_ROOT}" ]; then
    function pyenv_rehash { pyenv rehash }
    custom_rehash_hooks=( pyenv_rehash "${custom_rehash_hooks[@]}" )
  fi
fi
