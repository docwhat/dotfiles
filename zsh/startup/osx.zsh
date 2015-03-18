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

  function set_iterm_profile()
  {
    echo -e "\033]50;SetProfile=$1\a"
  }

  function saydone()
  {
    local ec=$?

    local prog='
    phrases=%w(done over finished ended concluded terminated dead gone) + ["over and done with", "at an end", "no more", "in the past"]
    puts "The process is #{phrases.sample}."
    '

    local phrase="$(ruby -e "${prog}")"
    if [ 0 != "${ec}" ]; then
      say -r 270 "Uh-oh! ${phrase} The exit code was $ec."
      echo " ** ${phrase} The exit code was $ec **" 1>&2
    else
      say -r 300 "${phrase}."
    fi

    return $ec
  }

  export BROWSER='open'
fi
