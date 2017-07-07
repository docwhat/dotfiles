if [[ "${OSTYPE}" == darwin* ]]; then
  # The macOS built in zsh config files are horrible.
  unsetopt global_rcs

  # I'm not entirely sure what this does...
  disable log
fi
