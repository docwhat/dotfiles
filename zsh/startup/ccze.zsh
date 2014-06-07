if (( $+commands[ccze] )); then
  function tailf()
  {
    tail -F "$@" | =ccze -C
  }
  alias ccze="ccze -m ansi"

  if [[ "$OSTYPE" = linux* ]]; then
    alias cps="ps -u root U `whoami` --forest -o pid,stat,tty,user,command |ccze -m ansi"
  fi
fi

