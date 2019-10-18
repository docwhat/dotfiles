if (( $+commands[asdf] )) && [[ -d "$ASDF_DIR" ]]; then
  alias aoeu=asdf
  source "${ASDF_DIR}/asdf.sh"
  source "${ASDF_DIR}/etc/bash_completion.d/asdf.bash"
fi

# vim: set ft=zsh :
