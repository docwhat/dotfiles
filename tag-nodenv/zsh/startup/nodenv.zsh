if (( ${+commands[nodenv]} )); then
  function nodenv_rehash { command nodenv rehash }
  custom_rehash_hooks=( nodenv_rehash "${custom_rehash_hooks[@]}" )

  eval "$(nodenv init - | sed -e 's/^\(command.*null$\)/& \&!/')"
fi
