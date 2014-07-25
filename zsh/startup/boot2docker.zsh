#!/usr/bin/env zsh

function boot2docker-reshell
{
  sudo -v
  ip=$(boot2docker ip 2>/dev/null)
  port=$(boot2docker config 2>/dev/null | perl -n -e 'print $1 if m/^DockerPort\s*=\s*(\d+)$/;')

  export DOCKER_HOST="tcp://${ip}:${port}"
  echo "export DOCKER_HOST=${DOCKER_HOST}" > ~/.zsh/startup/boot2docker.zshenv

  sudo -H ruby ~/.zsh/startup/boot2docker-host.rb "${ip}"
}
