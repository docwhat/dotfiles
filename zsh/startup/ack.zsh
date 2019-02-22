# vim: ft=zsh :

# While this is named after ack, when I
# switched search tools I didn't
# rename the file.

if (( $+commands[rg] )); then
  function rg() {
    if [ -t 1 ]; then
      =rg --pretty "$@" | less -RFX
    else
      =rg "$@"
    fi
  }
fi

if (( $+commands[ag] )); then
  alias  ag="ag --pager 'less -RS' --smart-case -C3 --color-line-number '1;34' --color-match '1;04;31' --color-path '1;32'"
fi

# EOF
