#!/usr/bin/env zsh

if [ -z "${DOTFILES_DIR:-}" ]; then
  echo "You must only source $0 after setting DOTFILES_DIR." 1>&2
  exit 1
fi

function hh_colorize
{
  local color="${1:-}"

  if [ -z "${color}" ]; then
    cat
  else
    while IFS='' read line; do
      print -P "%F{$color}$line%F{reset}"
    done
  fi
}

function hh_offset
{
  local color="${1:-}"

  while IFS='' read line; do
    echo "  $line" | hh_colorize "$color"
  done
}

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
      print -P "skipping...clone manually into ${dir} if you want." | hh_offset magenta
    else
      if [ -n "${parent}" ]; then
        mkdir -pv "${parent}" | hh_offset yellow
      fi
      git clone "${url}" "${dir}" | hh_offset yellow
      echo 'cloned.'
    fi
  else
    pushd "${dir}" > /dev/null
    if git diff-index --quiet HEAD; then
      git pull --rebase 2>/dev/null | hh_offset yellow
      git log --graph --pretty=format:'%Cred%h%Creset - %<(50,trunc)%s%Cgreen (%cr)%C(blue bold)%d%Creset%n' '@{u}..' | hh_offset
    else
      echo "Can't update ${dir} repository due to changes." | hh_offset red
      git -c color.status=always status --short | hh_offset | hh_offset
    fi
    popd > /dev/null
  fi
}
