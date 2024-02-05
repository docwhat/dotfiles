# 1Password shell integration.

if command -v op 1>/dev/null 2>&1; then
  # shellcheck disable=SC1090,SC2312
  source <(op completion bash)

  if [[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/op/plugins.sh" ]]; then
    # shellcheck disable=SC1091
    source "${XDG_CONFIG_HOME:-${HOME}/.config}/op/plugins.sh"
  fi
fi

# EOF
