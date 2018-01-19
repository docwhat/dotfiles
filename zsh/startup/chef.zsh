if [[ -d /opt/chef || -d /opt/chefdk || -d ~/.chef ]]; then
  alias kl="kitchen list"
  alias kc="kitchen converge"
  alias kv="kitchen verify"
  alias kd="kitchen destroy"
  alias kt="kitchen test"

  # https://github.com/someara/kitchen-dokken
  # https://kitchen.ci/docs/faq
  KITCHEN_YAML=.kitchen.yml
  KITCHEN_LOCAL_YAML=.kitchen.dokken.yml
  export KITCHEN_YAML KITCHEN_LOCAL_YAML

  function ks
  {
    case "$TERM" in
      screen*)
        new_term=screen
        ;;
      tmux*)
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
