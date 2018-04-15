if [ "${ZSH_ENABLENODE}" != false ]; then
  if (( $+commands[nodenv] )) && [ -d "${NODENV_ROOT}" ]; then
    # TODO make this smarter
    # Only run nodenv rehash if it was run over 5 minutes ago.
    for i in "${NODENV_ROOT}/shims"(/Nmm+5); do
      touch "${NODENV_ROOT}/shims"
      {
        nodenv rehash
      } &!
    done

    function nodenv_rehash { nodenv rehash }
    custom_rehash_hooks=( nodenv_rehash "${custom_rehash_hooks[@]}" )
  fi
fi
