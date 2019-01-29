#!/usr/bin/env zsh

if [ -z "${DOTFILES_DIR:-}" ]; then
  echo "You must only source $0 after setting DOTFILES_DIR." 1>&2
  exit 1
fi

fpath=("${DOTFILES_DIR}/zsh/functions" "${fpath[@]}")
autoload -Uz "${DOTFILES_DIR}/zsh/functions"/*(N:t)

function hh_curl
{
  local name=$1
  local file=$2
  local url=$3

  print -P "%F{cyan}⇣ %F{blue}${name} %F{reset}"
  if [[ ! -f "$file" ]]; then
    curl -qsSfL -o "$file" "$url"
  else
    curl -qsSfL -z "$file" -o "$file" "$url"
  fi
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
      print -P "skipping...clone manually into ${dir} if you want." | offset | colorize magenta
    else
      if [ -n "${parent}" ]; then
        mkdir -pv "${parent}" | offset yellow
      fi
      git clone "${url}" "${dir}" | offset yellow
      echo 'cloned.'
    fi
  else
    pushd "${dir}" > /dev/null
    if [[ -z "$(git status --porcelain=v2)" ]]; then
      git pull --rebase 2>/dev/null | offset | colorize yellow
      git log --graph --pretty=format:'%Cred%h%Creset - %<(50,trunc)%s%Cgreen (%cr)%C(blue bold)%d%Creset%n' '@{u}..' | offset
    else
      echo "Can't update ${dir} repository due to changes:" | offset | colorize red
      git -c color.status=always status --short | offset | offset
    fi
    popd > /dev/null
  fi
}
