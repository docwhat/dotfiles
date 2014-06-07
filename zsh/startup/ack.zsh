if (( $+commands[ag] )); then
  alias  ag="ag --pager 'less -RS' --smart-case -C3 --color-line-number '1;34' --color-match '1;04;31' --color-path '1;32'"
  alias ack="ag --pager 'less -RS' --smart-case -C3 --color-line-number '1;34' --color-match '1;04;31' --color-path '1;32'"
fi
if (( $+commands[ack] )); then
  alias hl="ack --passthru"
fi
