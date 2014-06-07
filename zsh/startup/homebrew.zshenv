# vim: ft=zsh :

# Settings related to homebrew
if (( $+commands[brew] )); then
  # Docbook support
  export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

  # Extra ZSH completions from Homebrew packages
  if [[ -d /usr/local/share/zsh/site-completions ]]; then
    fpath=(/usr/local/share/zsh/site-completions "${fpath[@]}")
  fi
  if [[ -d /usr/local/share/zsh-completions ]]; then
    fpath=(/usr/local/share/zsh-completions "${fpath[@]}")
  fi

  # Groovy
  if [[ -d /usr/local/opt/groovy/libexec ]]; then
    export GROOVY_HOME=/usr/local/opt/groovy/libexec
  fi
fi
