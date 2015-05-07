if [[ -d /opt/chef || -d /opt/chefdk || -d ~/.chef ]]; then
  alias kl="kitchen list"
  alias kc="kitchen converge"
  alias kv="kitchen verify"
  alias kd="kitchen destroy"
  alias kt="kitchen test"
  function ks
  {
    case "$TERM" in
      screen*)
        new_term=screen
        ;;
      xterm*)
        new_term=xterm
        ;;
      *)
        new_term=$TERM
    esac

    env TERM="${new_term}" kitchen login "$@"
  }
fi
