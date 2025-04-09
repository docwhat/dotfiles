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

## Load completions
mise use --global --quiet --silent usage >/dev/null
mise completion zsh > ~/.zsh/functions/_mise

## Cleanup
unset _docwhat_mise_path

# EOF
