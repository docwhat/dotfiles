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

## Install missing required tools.
"${_docwhat_mise_path}" --quiet --silent --yes install >/dev/null

## Load completions
"${_docwhat_mise_path}" --quiet --silent --yes use --global usage >/dev/null
# shellcheck disable=SC1090,SC2312
source <("${_docwhat_mise_path}" completion bash --include-bash-completion-lib)

# Use bat-extras if available
if command -v rg &>/dev/null && command -v batgrep &>/dev/null && command -v batman &>/dev/null; then
  alias rg=batgrep
  alias man=batman
fi

## Cleanup
unset _docwhat_mise_path

# EOF
