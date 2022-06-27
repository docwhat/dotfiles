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
  local target

  for comp in docker docker-compose docker-machine; do
    target=~/.zsh/functions/_"$comp"

    # remove broken links
    if ! [[ -L "$target" ]]; then rm -f "$target"; fi

    if [[ -a "$base_dir/etc/$comp.zsh-completion" ]]; then
      ln -nsf "$base_dir/etc/$comp.zsh-completion" "$target"
    elif [[ -a "$base_dir/etc/_$comp" ]];then
      ln -nsf "$base_dir/etc/_$comp" "$target"
    fi
  done
}
