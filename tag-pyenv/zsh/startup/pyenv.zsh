if (( ${+commands[pyenv]} )); then
  function pyenv_rehash { command pyenv rehash }
  custom_rehash_hooks=( pyenv_rehash "${custom_rehash_hooks[@]}" )

  eval "$(pyenv init - | sed -e 's/^\(command.*null$\)/& \&!/')"
fi
