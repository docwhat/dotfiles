if [ "${ZSH_ENABLERUBY}" != false ]; then
  if [ -d "${RBENV_ROOT}" ]; then
    mkdir -p "${RBENV_ROOT}/cache"
    function rbenv_rehash { rbenv rehash }
    custom_rehash_hooks=( rbenv_rehash "${custom_rehash_hooks[@]}" )
  fi
fi
