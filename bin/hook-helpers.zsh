#!/usr/bin/env zsh

if [ -z "${DOTFILE_DIR:-}" ]; then
  echo "You must only source $0 after setting DOTFILE_DIR." 1>&2
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

  cd "${DOTFILE_DIR}"

  print -P "%F{cyan}∓ %F{blue}${name} %F{reset}"
  if [ ! -d "${dir}" ]; then
    if [ -n "${parent}" ]; then
      mkdir -pv "${parent}" | offset yellow
    fi
    git clone "${url}" "${dir}" | offset yellow
    echo 'cloned.'
  else
    pushd "${dir}" > /dev/null
    if git diff-index --quiet HEAD; then
      git pull --rebase | offset yellow
    else
      print -P "%F{red}Can't update ${dir} repository due to changes."
    fi
    popd > /dev/null
  fi
}
