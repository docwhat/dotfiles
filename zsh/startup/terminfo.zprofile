#!/bin/zsh

# Install terminfo stuff if missing.
if (( $+commands[tic] )) && (( $+commands[tput] )); then
  install_term=f

  case "$TERM" in
  tmux|tmux-256color)
    install_term=t ;;
  esac

  if [ "$install_term" = t ] && \
    ! tput cols >/dev/null 2>/dev/null
  then
    tic -x "${HOME}/.config/terminfo/${TERM}.terminfo"
    export TERM=$TERM
  fi

  unset install_term
fi

# EOF
