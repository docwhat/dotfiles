if (( $+commands[grep] )); then
  unset GREP_OPTIONS
  alias grep='grep --color=auto'

  if [[ $(echotc Co) -ge 256 ]]; then
    export GREP_COLORS="mt=38;5;166;48;5;234:sl=38;5;33:cx=38;5;27:fn=38;5;136:ln=38;5;61:bn=38;5;64:se=38;5;33"
  else
    export GREP_COLORS="mt=31:sl=:cx=:fn=34:ln=1;30:bn=30:se=30"
  fi
fi
