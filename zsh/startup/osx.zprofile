if [[ "${OSTYPE}" == darwin* ]]; then
  if [ -x /usr/local/bin/zsh ]; then
    export SHELL=/usr/local/bin/zsh
  fi

  export TERMINAL_NOTIFIER_BIN=$HOME/.bin/terminal-notifier
fi
