# vi: ft=zsh :

# Less Options
export LESS='-asXFMMRqix8'
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-' LESS_ADVANCED_PREPROCESSOR=1
elif (( $+commands[lesspipe] )); then
  export LESSOPEN='| /usr/bin/env lesspipe %s 2>&-' LESS_ADVANCED_PREPROCESSOR=1
fi

# Pager/Editors
export PAGER="less"
export ACK_PAGER="less -R -+F"
export GIT_EDITOR="vim +1"
export EDITOR="vim"

# Use NeoVim if it exists
if (( $+commands[nvim] )); then
  export GIT_EDITOR="nvim +1"
  export EDITOR="nvim"
  alias vim=nvim
  alias vi=nvim
fi

export FPP_EDITOR="$EDITOR"
export MANPAGER="${HOME}/bin/manpager"
export VISUAL="${HOME}/bin/visual-editor"

# EOF
