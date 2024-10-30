function {
  (( ${+commands[podman]} )) || return
  setopt local_options equals extended_glob

  local exe==podman
  local comp=~/.zsh/functions/_podman

  if [[ "$exe" -nt "$comp" ]] || ! [[ -a "$comp" ]]; then
    podman completion zsh > "$comp"
  fi
}
