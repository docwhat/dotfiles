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
export DELTA_PAGER="less"
export ACK_PAGER="less -RF"
unset BAT_PAGER # BAT_PAGER causes an infinite loop with bat
export MANPAGER="${HOME}/bin/manpager"

export EDITOR="${HOME}/bin/editor"
export VISUAL="${HOME}/bin/visual-editor"

export GIT_EDITOR="$EDITOR +1"
export FPP_EDITOR=$EDITOR
export REACT_EDITOR=$EDITOR

# EOF
