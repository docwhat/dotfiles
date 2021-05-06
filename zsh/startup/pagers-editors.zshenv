# vi: ft=zsh :

export REACT_EDITOR=atom

# Use NeoVim if it exists
if (( ${+commands[nvim]} )); then
  alias vim=nvim
  alias vi=nvim
  alias view="nvim -R -c 'set nomodifiable'"
  alias vimdiff="nvim -d"
fi

# Pager/Editors
export PAGER="bat"
export ACK_PAGER="less -R -+F"
export BAT_PAGER="less -R -+F"
export MANPAGER="${HOME}/bin/manpager"

export EDITOR="${HOME}/bin/editor"
export VISUAL="${HOME}/bin/visual-editor"

export GIT_EDITOR="$EDITOR +1"
export FPP_EDITOR=$EDITOR
export REACT_EDITOR=$EDITOR

# EOF
