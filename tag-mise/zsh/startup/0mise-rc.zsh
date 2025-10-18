## Install mise if not installed.
if ! (( $+commands[mise] )); then
  if (( $+commands[curl] )); then
    curl https://mise.run | env MISE_QUIET=1 sh

    # Verify the installation.
    _docwhat_mise_path=${MISE_INSTALL_PATH:-${HOME}/.local/bin/mise}
    "${_docwhat_mise_path}" doctor --quiet --silent >/dev/null
  elif (( $+commands[brew] )); then
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
eval "$("${_docwhat_mise_path}" activate zsh)" || :

## Install missing required tools.
"${_docwhat_mise_path}" --quiet --silent --yes install >/dev/null

## Load completions
"${_docwhat_mise_path}" --quiet --silent --yes use --global usage >/dev/null
"${_docwhat_mise_path}" completion zsh > ~/.zsh/functions/_mise

# Use bat-extras if available
if (( $+commands[rg] )) && (( $+commands[batgrep] )) && (( $+commands[batman] )); then
  alias rg=batgrep
  compdef _rg rg
  alias man=batman
  compdef _man man
fi

## Cleanup
unset _docwhat_mise_path

# EOF
