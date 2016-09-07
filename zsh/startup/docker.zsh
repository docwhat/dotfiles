# vim: ft=zsh :

## Ensure docker-compose doesn't get messed up by certificate settings.
if (( $+commands[docker-compose] )); then
  alias docker-compose="env -u REQUESTS_CA_BUNDLE docker-compose"
fi

# Set up default docker-machine, unless Docker.app is available.
if [ ! -d /Applications/Docker.app ] && (( $+commands[docker-machine] )); then
  if [ -n "$(docker-machine ls --filter='state=running' --filter='name=default' --format='ok' 2>/dev/null)" ]; then
    eval "$(docker-machine env default </dev/null 2>/dev/null)"
  fi
fi

## Completion
function fetch_docker_completion
{
  local cmd=$1
  local file="${HOME}/.zsh/functions/_${cmd}"
  local url=$2

  if (( $+commands[$cmd] )); then
    if [[ ! -f "$file" || $commands[$cmd] -nt "$file" ]]; then
      curl -qsSfL -o "$file" "$url"
    fi
  fi
}

fetch_docker_completion docker           https://raw.githubusercontent.com/docker/docker/master/contrib/completion/zsh/_docker
fetch_docker_completion docker-compose   https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose
fetch_docker_completion docker-machine   https://raw.githubusercontent.com/docker/machine/master/contrib/completion/zsh/_docker-machine

unfunction fetch_docker_completion
