# vim: ft=zsh :

if (( $+commands[dotnet] )); then
  _dotnet_zsh_complete() {
    local completions=("$(dotnet complete "$words")")

    reply=( "${(ps:\n:)completions}" )
  }

  compctl -K _dotnet_zsh_complete dotnet
fi
