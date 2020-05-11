if [ "${ZSH_ENABLERUBY}" != false ]; then
  if [ -d "${RBENV_ROOT}" ]; then
    mkdir -p "${RBENV_ROOT}/cache"

    # TODO make this smarter
    # Only run rbenv rehash if it was run over 5 minutes ago.
    for i in "${RBENV_ROOT}/shims"(/Nmm+5); do
      touch "${RBENV_ROOT}/shims"
      {
        rbenv rehash
      } &!
    done

    function rbenv_rehash { rbenv rehash }
    custom_rehash_hooks=( rbenv_rehash "${custom_rehash_hooks[@]}" )
  fi
fi
