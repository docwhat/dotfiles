if (( ${+commands[rbenv]} )); then
  function rbenv_rehash { command rbenv rehash }
  custom_rehash_hooks=( rbenv_rehash "${custom_rehash_hooks[@]}" )

  eval "$(rbenv init - | sed -e 's/^\(command.*null$\)/& \&!/')"
fi
