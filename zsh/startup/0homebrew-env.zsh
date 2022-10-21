# vim: set ft=zsh :

function {
  local brewbin
  for brewbin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$brewbin" ]]; then
      eval "$("$brewbin" shellenv zsh)"
      INFOPATH=${INFOPATH%:}
      MANPATH=${MANPATH%:}
      export INFOPATH MANPATH

      break
    fi
  done
}
