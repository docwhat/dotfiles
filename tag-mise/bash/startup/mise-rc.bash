# Install mise if not installed.
if ! command -v mise &>/dev/null; then
  if command -v curl &>/dev/null; then
    # shellcheck disable=2312
    curl https://mise.run | env MISE_QUIET=1 sh

    # Verify the installation.
    _docwhat_mise_path="${MISE_INSTALL_PATH:-${HOME}/.local/bin}/mise"
    "${_docwhat_mise_path}" doctor --quiet --silent >/dev/null
  elif command -v brew &>/dev/null; then
    brew install mise
    _docwhat_mise_path="$(brew --prefix mise)/bin/mise"
  fi
else
  _docwhat_mise_path="$(command -v mise)"
fi

if ! [[ -x "${_docwhat_mise_path:-}" ]]; then
  return
fi

## Activate mise.
# shellcheck disable=2312
eval "$("${_docwhat_mise_path}" activate bash)"

## Load completions
mise use --global --quiet --silent usage >/dev/null
# shellcheck disable=SC1090,SC2312
source <(mise completion bash --include-bash-completion-lib)

## Cleanup
unset _docwhat_mise_path

# EOF
