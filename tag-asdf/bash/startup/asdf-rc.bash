## Try installing asdf if not already available.
if ! command -v asdf &>/dev/null; then
  if command -v brew &>/dev/null; then
    brew install --quiet asdf
  fi
fi

## Abort if not available.
if ! command -v asdf &>/dev/null; then
  return
fi

# shellcheck disable=SC1090
. <(asdf completion bash || true)

# EOF
