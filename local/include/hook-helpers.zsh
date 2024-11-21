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
  setopt local_options err_return
  local usage="Usage: hh_git [--dir DIR] [--branch BRANCH] NAME URL"
  local name url dir="" branch

  while (( $# > 0 )); do
    case $1 in
      --dir|-d)
        dir=$2
        shift
        ;;
      --dir=*)
        dir="${1#*=}"
        ;;
      --branch|-b)
        branch=$2
        shift
        ;;
      --branch=*)
          branch="${1#*=}"
          ;;
      *)
        if [[ -z ${name-} ]]; then
          name=$1
        elif [[ -z ${url-} ]]; then
          url=$1
        else
          printf "Unknown argument: %s\n%s\n" "$1" "$usage" 1>&2
        fi
          ;;
      esac
    shift
  done

  if [[ -z ${name-} ]]; then
    printf "Name is required.\n%s\n" "$usage" 1>&2
    return 1
  fi

  if [[ -z ${url-} ]]; then
    printf "URL is required.\n%s\n" "$usage" 1>&2
    return 1
  fi

  if [[ -z "${dir-}" ]]; then
    dir="$(basename "${url}" .git)"
  fi

  local parent="$(dirname "${dir}")"
  local git_options=()

  cd "${DOTFILES_DIR}"

  print -P "%F{cyan}∓ %F{blue}${name} %F{reset}"
  if [ ! -d "${dir}" ]; then
    if [ "${url}" = none ]; then
      print -P "skipping...clone manually into ${dir} if you want." | offset | colorize magenta
    else
      if [ -n "${parent}" ]; then
        mkdir -pv "${parent}" | offset yellow
      fi

      if [[ -n "${branch-}" ]]; then
        local git_options=("--branch" "${branch}")
      fi

      git clone "${url}" "${dir}" "${git_options[@]}" | offset yellow
      echo 'cloned.'
    fi
  else
    pushd "${dir}" > /dev/null
    if [[ -n "${branch-}" ]]; then
      local git_options=(origin -- "${branch}")
      git -c color.status=always -c core.warnAmbiguousRefs=false switch --detach -- "${branch}" |&
        offset
    fi
    git -c color.status=always pull --rebase --autostash "${git_options[@]}" |&
      offset
    git -c color.status=always log --graph --pretty=format:'%Cred%h%Creset - %<(50,trunc)%s%Cgreen (%cr)%C(blue bold)%d%Creset%n' '@{u}..' |&
      offset || :
    git -c color.status=always status --short --branch --show-stash |&
      offset || :
    popd > /dev/null
  fi
}
