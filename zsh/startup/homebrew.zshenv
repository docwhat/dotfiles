# Settings related to homebrew
if (( $+commands[brew] )); then

  # Extra ZSH completions from Homebrew packages
  if [[ -d /usr/local/share/zsh/site-completions ]]; then
    fpath=(/usr/local/share/zsh/site-completions "${fpath[@]}")
  fi
  if [[ -d /usr/local/share/zsh/site-functions ]]; then
    fpath=(/usr/local/share/zsh/site-functions "${fpath[@]}")
  fi
  if [[ -d /usr/local/share/zsh-completions ]]; then
    fpath=(/usr/local/share/zsh-completions "${fpath[@]}")
  fi

  function brew-fast-update() {
    if (( $+commands[parallel] )); then
      /usr/bin/find /usr/local -name '.git' -type d -print0 \
        | parallel --progress --eta -j+0 -0 '(set -e ; cd {} ; cd .. ; echo -en "\n====> " ; pwd ; git fetch --all --prune ; git prune ; git checkout master ; git reset origin/master) 1>&2'
    else
      /usr/bin/find /usr/local -name '.git' -type d -print0 \
        | /usr/bin/xargs -0 -Iqq bash -c '(set -e ; cd qq ; cd .. ; echo -n "====> " ; pwd ; git fetch --all --prune ; git prune ; git checkout master ; git reset origin/master) 1>&2'
    fi

    echo -e "\n\n"
    brew outdated
  }

  # Disable auto update; it is annoyingly slow.
  export HOMEBREW_NO_AUTO_UPDATE=1
fi

# vim: set ft=zsh :
