# vim: set ft=bash :

homebrew-env() {
  if [[ -d "${HOMEBREW_PREFIX}" ]]; then
    return # We're setup already.
  fi

  local brewbin
  for brewbin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [[ -x "${brewbin}" ]]; then
      eval "$("${brewbin}" shellenv)"
      INFOPATH=${INFOPATH%:}
      export INFOPATH

      break
    fi
  done
}
homebrew-env
unset -f homebrew-env
