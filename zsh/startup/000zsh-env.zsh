# vim: set ft=zsh :

# Use the default basedir values.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# On MacOS, use the ~/Library/Caches directory.
if [[ -d "${HOME}/Library/Caches" ]] && [[ "${OSTYPE}" = darwin* ]]; then
  XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/Library/Caches}"
else
  XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
fi

ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"

# EOF
