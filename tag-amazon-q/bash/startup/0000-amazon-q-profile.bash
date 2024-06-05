if [[ -x ~/.local/bin/q ]]; then
  eval "$(~/.local/bin/q init bash pre --rcfile profile)" || true
fi
