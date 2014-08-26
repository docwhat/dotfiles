#!/usr/bin/env zsh

function boot2docker-fixup
{
  sudo -v
  ip=$(boot2docker ip 2>/dev/null)
  port=$(boot2docker config 2>/dev/null | perl -n -e 'print $1 if m/^DockerPort\s*=\s*(\d+)$/;')
  if [ "${port}" = "0" ]; then
    # https://github.com/boot2docker/boot2docker/issues/504
    port=2375
  fi

  export DOCKER_HOST="tcp://${ip}:${port}"
  echo "export DOCKER_HOST=${DOCKER_HOST}" > ~/.zsh/startup/boot2docker.zshenv

  sudo -H ruby ~/.zsh/startup/boot2docker-host.rb "${ip}"

  ~/.zsh/startup/boot2docker-fixup.sh
}
