if command -v asdf >/dev/null; then
  asdf plugin-add starship >/dev/null 2>&1
  asdf install starship latest >/dev/null 2>&1
fi

if command -v starship >/dev/null; then
  eval "$(starship init bash)" || true
fi
