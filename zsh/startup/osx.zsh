if [[ "${OSTYPE}" == darwin* ]]; then
  alias ldd="otool -L"

  if (( $+commands[archey] )); then
    alias archey="archey --color"
  fi

  if [[ "${DISPLAY}" == *macosforge.xquartz* ]]; then
    export DISPLAY_OFF="${DISPLAY}"
    unset DISPLAY
  fi

  function x11-toggle()
  {
    if [[ -z "${DISPLAY}" && -n "${DISPLAY_OFF}" ]]; then
      echo "Turning X11 back on" 1>&2
      export DISPLAY="${DISPLAY_OFF}"
      unset DISPLAY_OFF
    elif [[ -n "${DISPLAY}" && -z "${DISPLAY_OFF}" ]]; then
      echo "Turning X11 back off" 1>&2
      export DISPLAY_OFF="${DISPLAY}"
      unset DISPLAY
    fi
  }

  function saydone()
  {
    local ec=$?

    local prog='
    phrases=%w(done over finished ended concluded terminated dead gone) + ["over and done with", "at an end", "no more", "in the past"]
    puts "The process is #{phrases.sample}"
    '

    local phrase="$(ruby -e "${prog}")"
    if [ 0 != "${ec}" ]; then
      say "Uh-oh!"
      echo " ** ${phrase} with exit code $ec **" 1>&2
    fi

    say "${phrase} with $ec"
  }

  export BROWSER='open'
fi
