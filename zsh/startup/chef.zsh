if [[ -d /opt/chef || -d /opt/chefdk || -d ~/.chef ]]; then
  function require-kitchen-yml
  {
    if [ ! -d .kitchen.yml ]; then
      echo 'No .kitchen.yml present!' 1>&2
      return 1
    fi
  }
  alias kl="require-kitchen-yml && chef exec kitchen list"
  alias kc="require-kitchen-yml && chef exec kitchen converge"
  alias kv="require-kitchen-yml && chef exec kitchen verify"
  alias kd="require-kitchen-yml && chef exec kitchen destroy"
  alias kt="require-kitchen-yml && chef exec kitchen test"

  # https://github.com/someara/kitchen-dokken
  # https://kitchen.ci/docs/faq
  KITCHEN_YAML=.kitchen.yml
  KITCHEN_LOCAL_YAML=.kitchen.dokken.yml
  export KITCHEN_YAML KITCHEN_LOCAL_YAML

  function ks
  {
    require-kitchen-yml || return 1

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
