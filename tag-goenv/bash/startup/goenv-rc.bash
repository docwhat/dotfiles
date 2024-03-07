if command -v goenv >/dev/null; then
  mkdir -p "$GOENV_ROOT"
  eval "$(goenv init - --no-rehash bash)"
fi
