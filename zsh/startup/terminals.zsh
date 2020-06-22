function simplify-term() {
  local "new_term=${TERM}"

  case "$TERM" in
    screen-256color|tmux-256color)
      new_term=screen-256color
      ;;
    screen*|tmux*)
      new_term=screen
      ;;
    xterm-256color|xterm-kitty)
      new_term=xterm-256color
      ;;
    xterm*)
      new_term=xterm
      ;;
  esac

  (export "TERM=${new_term}" && "$@")
}
