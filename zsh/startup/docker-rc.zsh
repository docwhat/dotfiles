# vim: ft=zsh :

# Set up default docker-machine, unless Docker.app is available.
if [ ! -d /Applications/Docker.app ] && (( ${+commands[docker-machine]} )); then
  if [ -n "$(docker-machine ls --filter='state=running' --filter='name=default' --format='ok' 2>/dev/null)" ]; then
    eval "$(docker-machine env default </dev/null 2>/dev/null)"
  fi
fi

function {
  (( ${+commands[docker]} )) || return
  setopt local_options equals extended_glob

  local exe==docker
  local base_dir=${exe:A:h:h}
  local comp

  for comp in docker docker-compose docker-machine; do
    [[ -f "$base_dir"/etc/"$comp".zsh-completion ]] && \
    ln -nsf "$base_dir"/etc/"$comp".zsh-completion ~/.zsh/functions/_"$comp"
  done
}
