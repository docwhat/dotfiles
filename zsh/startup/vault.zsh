
if [ -n "${commands[vault]}" ]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "${commands[vault]}" vault
fi

