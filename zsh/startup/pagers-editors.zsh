# Less Options
export LESS='-asXFMMRqix8'
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
elif (( $+commands[lesspipe] )); then
  export LESSOPEN='| /usr/bin/env lesspipe %s 2>&-'
fi

# Pager/Editors
export PAGER="less"
export ACK_PAGER="less -R -+F"
export GIT_EDITOR="vim +1"
export EDITOR="vim"

if (( $+commands[mvim] )); then
  export VISUAL=mvim
elif (( $+commands[gvim] )); then
  export VISUAL=gvim
else
  export VISUAL=vim
fi

function man
{
  ## Mine
  env \
    LESS_TERMCAP_mb=$'\E[01;38;5;160m' \
    LESS_TERMCAP_md=$'\E[01;38;5;37m' \
    LESS_TERMCAP_so=$'\E[03;38;5;120m' \
    LESS_TERMCAP_us=$'\E[04;38;5;136m' \
    LESS_TERMCAP_mr=$'\E[7m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    "$commands[man]" "$@"

  ## Less Colors for Man Pages - http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
  #export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
  #export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
  #export LESS_TERMCAP_me=$'\E[0m'           # end mode
  #export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
  #export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
  #export LESS_TERMCAP_ue=$'\E[0m'           # end underline
  #export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

  ## http://serverfault.com/questions/35169/unable-to-change-the-font-in-bold-to-yellow-font-in-less
  #export LESS_TERMCAP_mb=$'\E[01;31m'     # begin blinking
  #export LESS_TERMCAP_md=$'\E[01;31m'    # begin bold
  #export LESS_TERMCAP_me=$'\E[0m'        # end mode
  #export LESS_TERMCAP_se=$'\E[0m'        # end standout-mode
  #export LESS_TERMCAP_so=$'\E[01;44;33m' # begin standout-mode
  #export LESS_TERMCAP_ue=$'\E[0m'        # end underline
  #export LESS_TERMCAP_us=$'\E[01;32m'    # begin underline

  ## http://superuser.com/questions/146182/colorizing-your-terminal-and-shell-environment
  #export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
  #export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
  #export LESS_TERMCAP_me=$(tput sgr0)
  #export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
  #export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
  #export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
  #export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
  #export LESS_TERMCAP_mr=$(tput rev)
  #export LESS_TERMCAP_mh=$(tput dim)
  #export LESS_TERMCAP_ZN=$(tput ssubm)
  #export LESS_TERMCAP_ZV=$(tput rsubm)
  #export LESS_TERMCAP_ZO=$(tput ssupm)
  #export LESS_TERMCAP_ZW=$(tput rsupm)
}
