# vi: ft=zsh :

export REACT_EDITOR=code

# Use NeoVim if it exists
if (( ${+commands[nvim]} )); then
  alias vim=nvim
  alias vi=nvim
  alias view="nvimpager"
  alias vimdiff="nvim -d"
  export ACK_PAGER="nvimpager"
  export BAT_PAGER="nvimpager"
else
  export ACK_PAGER="less -RF"
  export BAT_PAGER="less -RF"
fi

# Pager/Editors
export PAGER="bat"
export MANPAGER="${HOME}/bin/manpager"

export EDITOR="${HOME}/bin/editor"
export VISUAL="${HOME}/bin/visual-editor"

export GIT_EDITOR="$EDITOR +1"
export FPP_EDITOR=$EDITOR
export REACT_EDITOR=$EDITOR

# EOF
