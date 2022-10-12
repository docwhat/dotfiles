# vim: ft=zsh :

if (( ${+commands[docker]} )); then
  export DOCKER_BUILDKIT=1
fi

# Rancher Desktop
if [[ -d "$HOME/.rd/bin" ]]; then
  path+=("$HOME/.rd/bin")
fi
