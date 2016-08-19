# Settings related to homebrew
if (( $+commands[brew] )); then
  # Docbook support
  export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

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
