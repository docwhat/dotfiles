# Settings related to homebrew
if (( $+commands[brew] )); then
  # Docbook support
  export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

  # Groovy
  if [[ -d /usr/local/opt/groovy/libexec ]]; then
    export GROOVY_HOME=/usr/local/opt/groovy/libexec
  fi
fi

# vim: set ft=zsh :
