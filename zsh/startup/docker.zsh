# vim: ft=zsh :

## Ensure docker-compose doesn't get messed up by certificate settings.
if (( $+commands[docker-compose] )); then
  alias docker-compose="env -u REQUESTS_CA_BUNDLE docker-compose"
fi

if [ ! -d /Applications/Docker.app ] && (( $+commands[docker-machine] )); then
  if [ -n "$(docker-machine ls --filter='state=running' --filter='name=default' --format='ok' 2>/dev/null)" ]; then
    eval "$(docker-machine env default </dev/null 2>/dev/null)"
  fi
fi
