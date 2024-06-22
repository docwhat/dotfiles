# vim: set ft=bash :

homebrew-env() {
  local brewbin
  for brewbin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [[ -x "$brewbin" ]]; then
      eval "$("$brewbin" shellenv zsh)"
      INFOPATH=${INFOPATH%:}
      MANPATH=${MANPATH%:}
      export INFOPATH MANPATH

      break
    fi
  done
}
homebrew-env
unset -f homebrew-env
