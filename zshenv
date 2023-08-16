# vim: ft=zsh :

# unique paths
typeset -U manpath path fpath

if [[ -z "${__docwhat_zsh_loaded}" ]]; then
  # The path has to be set *first*
  path=(
    "$HOME/bin"
    "$HOME/.local/bin"
    /snap/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/local/share/npm/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    /opt/X11/bin
    "${path[@]}"
  )

  manpath=(
    /usr/local/share/man
    /usr/share/man
    /usr/X11/man
    /opt/X11/share/man
    "${manpath[@]}"
  )
fi

# Load my customized environment.
for config_file (~/.zsh/startup/*-env.zsh(rN)); do
  source "${config_file}"
done
unset config_file

export __docwhat_zsh_loaded=1

# EOF
