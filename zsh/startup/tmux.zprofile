# vim: ft=zsh :

if [ -n "$TMUX" ]; then
  case "$(tmux show-environment -g TERM)" in
    TERM=xterm-256color-italic) export TERM=screen-256color-italic ;;
    TERM=xterm-256color)        export TERM=screen-256color ;;
    TERM=xterm)                 export TERM=screen ;;
  esac
fi
