# Disable pagers when the terminal is launched by Cline
if [[ -n "$CLINE_ACTIVE" ]]; then
  export PAGER=cat
  export GIT_PAGER=cat
  export SYSTEMD_PAGER=cat
  export LESS="-FRX"
fi
