#!/usr/bin/env zsh

if [ -z "${DOTFILES_DIR:-}" ]; then
  echo "You must only source $0 after setting DOTFILES_DIR." 1>&2
  exit 1
fi

function offset
{
  local color="${1:-}"

  while read line; do
    [ -z "${color}" ] || print -nP "%F{$color}"
    echo "  $line"
    [ -z "${color}" ] || print -nP "%F{reset}"
  done
}

function hh_git
{
  local name=$1
  local url=$2
  local dir="${3:-}"
  local parent="$(dirname "${dir}")"

  if [ -z "${dir}" ]; then
    dir="$(basename "${url}" .git)"
  fi

  cd "${DOTFILES_DIR}"

  print -P "%F{cyan}∓ %F{blue}${name} %F{reset}"
  if [ ! -d "${dir}" ]; then
    if [ "${url}" = none ]; then
      print -P "skipping...clone manually into ${dir} if you want." | offset magenta
    else
      if [ -n "${parent}" ]; then
        mkdir -pv "${parent}" | offset yellow
      fi
      git clone "${url}" "${dir}" | offset yellow
      echo 'cloned.'
    fi
  else
    pushd "${dir}" > /dev/null
    if git diff-index --quiet HEAD; then
      git pull --rebase | offset yellow
      git log --graph --pretty=format:'%Cred%h%Creset - %<(50,trunc)%s%Cgreen (%cr)%C(blue bold)%d%Creset%n' '@{u}..' | offset
    else
      print -P "%F{red}Can't update ${dir} repository due to changes."
    fi
    popd > /dev/null
  fi
}
