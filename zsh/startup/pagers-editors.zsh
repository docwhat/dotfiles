# vi: ft=zsh :

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
export MANPAGER="${HOME}/.bin/manpager"
export VISUAL="${HOME}/.bin/visual-editor"

# EOF
