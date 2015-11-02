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

  # I also prefer the non-gprefix gnubins
  if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
    path=(/usr/local/opt/coreutils/libexec/gnubin "${path[@]}")
  fi
  if [ -d /usr/local/opt/coreutils/libexec/gnuman ]; then
    manpath=(/usr/local/opt/coreutils/libexec/gnuman "${manpath[@]}")
  fi
fi
