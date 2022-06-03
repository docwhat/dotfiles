# vim: set ft=zsh :

function {
  local brewbin
  for brewbin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$brewbin" ]]; then
      eval "$("$brewbin" shellenv zsh)"
      INFOPATH=${INFOPATH%:}
      MANPATH=${MANPATH%:}

      local brewfpath
      brewfpath=${${:-"${HOMEBREW_PREFIX}/share/zsh/functions/_git"}:A:h}
      if [[ -d "$brewfpath" ]] && (( ${fpath[(i)$brewfpath]} <= ${#fpath} )) ; then
        # git's contrib completion for zsh is ... sub-optimal.
        # Homebrew used to allow ditching it, but no more.
        # https://github.com/Homebrew/homebrew-core/issues/33275
        # This ensures homebrew goes early in the fpath.
        fpath=($brewfpath "${fpath[@]}")
      fi
      break
    fi
  done
}
