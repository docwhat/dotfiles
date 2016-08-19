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
fi
