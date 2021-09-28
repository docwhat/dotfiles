# vim: ft=zsh :

# Set up default docker-machine, unless Docker.app is available.
if [ ! -d /Applications/Docker.app ] && (( ${+commands[docker-machine]} )); then
  if [ -n "$(docker-machine ls --filter='state=running' --filter='name=default' --format='ok' 2>/dev/null)" ]; then
    eval "$(docker-machine env default </dev/null 2>/dev/null)"
  fi
fi
