function fix-tmux
{
  if [[ -n "${TMUX}" ]]; then
    tmux set-option update-environment ""
    if [[ -z "${SSH_AUTH_SOCK}" ]]; then
      export SSH_AUTH_SOCK=$(tmux showenv | grep '^SSH_AUTH_SOCK' | cut -d = -f 2)
      echo "Restored \$SSH_AUTH_SOCK from tmux"
    else
      tmux setenv SSH_AUTH_SOCK "${SSH_AUTH_SOCK}"
      echo "Saved \$SSH_AUTH_SOCK to tmux"
    fi
  fi
}
