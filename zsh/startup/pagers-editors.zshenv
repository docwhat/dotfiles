# vi: ft=zsh :

# Less Options
export LESS='-AFgiJMnqRsuXx4'
# A  - SEARCH-SKIP-SCREEN
# F  - quit-if-one-screen
# g  - hilite-search
# i  - ignore-case
# J  - quit-if-one-screen
# M  - LONG-PROMPT
# n  - line-numbers
# q  - silent
# R  - RAW-CONTROL-CHARS
# s  - squeeze-blank-lines
# u  - underline-special
# X  - no-init
# x4 - tabs=4

# Less pipe/highlighter
if (( $+commands[highlight] )); then
  if [ "$COLORTERM" = truecolor ]; then
    lf=truecolor
  elif [[ $(echotc Co) -ge 256 ]]; then
    lf=xterm256
  else
    lf=ansi
  fi
  LESSOPEN="| ${commands[highlight]} %s --out-format=${lf} --base16 --style=gruvbox-dark-hard --force --no-trailing-nl"
  unset lf
  export LESSOPEN
elif (( $+commands[src-hilite-lesspipe.sh] )); then
  LESSOPEN='| /usr/bin/env src-hilite-lesspipe.sh.sh %s 2>&-'
  export LESSOPEN
elif (( $+commands[lesspipe] )); then
  LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
  export LESSOPEN LESS_ADVANCED_PREPROCESSOR=1
elif (( $+commands[lesspipe] )); then
  LESSOPEN='| /usr/bin/env lesspipe %s 2>&-'
  export LESSOPEN
fi

export REACT_EDITOR=atom

# Use NeoVim if it exists
if (( $+commands[nvim] )); then
  alias vim=nvim
  alias vi=nvim
  alias view="nvim -R -c 'set nomodifiable'"
  alias vimdiff="nvim -d"
fi

# Pager/Editors
export PAGER="less"
export ACK_PAGER="less -R -+F"
export MANPAGER="${HOME}/bin/manpager"

export EDITOR="${HOME}/bin/editor"
export VISUAL="${HOME}/bin/visual-editor"

export GIT_EDITOR="$EDITOR +1"
export FPP_EDITOR=$EDITOR
export REACT_EDITOR=$EDITOR

# EOF
