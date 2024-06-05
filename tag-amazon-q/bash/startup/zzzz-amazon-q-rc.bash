if [[ -x ~/.local/bin/q ]]; then
  eval "$(~/.local/bin/q init bash post --rcfile bashrc)" || true
fi
