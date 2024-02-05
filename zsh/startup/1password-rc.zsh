# 1Password shell integration.

if (( $+commands[op] )); then
  eval "$(op completion zsh)"
  compdef _op op

  if [[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/op/plugins.sh" ]]; then
    source "${XDG_CONFIG_HOME:-${HOME}/.config}/op/plugins.sh"
  fi
fi

# EOF
