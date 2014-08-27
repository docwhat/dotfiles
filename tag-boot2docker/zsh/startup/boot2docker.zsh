#!/usr/bin/env zsh

function boot2docker-fixup
{
  sudo -v
  local ip=$(boot2docker ip 2>/dev/null)
  local docker_env="$(boot2docker shellinit)"

  eval "${docker_env}"
  echo "${docker_env}" > ~/.zsh/startup/boot2docker.zshenv

  sudo -H ruby ~/.zsh/startup/boot2docker-host.rb "${ip}"

  ~/.zsh/startup/boot2docker-fixup.sh
}
