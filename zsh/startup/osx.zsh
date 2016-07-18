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
puts "The process is #{phrases.sample}."
'

local phrase="$(ruby -e "${prog}")"
if [ 0 != "${ec}" ]; then
  say  "Uh-oh! ${phrase} The exit code was $ec."
  echo " ** ${phrase} The exit code was $ec **" 1>&2
else
  say "${phrase}."
fi

if (( $+functions[iterm-get-attention] )); then
  iterm-get-attention
fi

return $ec
  }

  function exclude-from-backup
  {
    local fname="$1"

    if [ ! -r "$fname" ]; then
      echo "No such file or directory: $fname" 1>&2
      return 2
    elif [[ "${fname:A}" =~ '.*/\..*' ]]; then
      echo "Hidden files cannot be controlled by xattr: $fname" 1>&2
      return 3
    else
      xattr \
        -w 'com.apple.metadata:com_apple_backup_excludeItem' 'com.apple.backupd' \
        "$fname"
    fi
  }

  function include-in-backup
  {
    local fname="$1"

    if [ ! -r "$fname" ]; then
      echo "No such file or directory: $fname" 1>&2
      return 2
    else
      xattr \
        -d 'com.apple.metadata:com_apple_backup_excludeItem' \
        "$fname"
    fi
  }

  function super-tools-update() {
    tools-update &&\
      rbenv-update-plugins &&\
      update-gems &&\
      (rbenv use system && brew update && brew upgrade) &&\
      vim -c ':PlugUpgrade' -c ':PlugUpdate' -c ':qa!'
    return $?
  }

  export BROWSER='open'
fi
