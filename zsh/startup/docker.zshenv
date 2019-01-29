# vim: ft=zsh :

if (( $+commands[docker] )); then
  export DOCKER_BUILDKIT=1
fi
