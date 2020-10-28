if [ "${ZSH_ENABLENODE}" != false ]; then
  if (( $+commands[nodenv] )) && [ -d "${NODENV_ROOT}" ]; then
    function nodenv_rehash { nodenv rehash }
    custom_rehash_hooks=( nodenv_rehash "${custom_rehash_hooks[@]}" )
  fi
fi
