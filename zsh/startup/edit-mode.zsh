if (( ${plugins[(i)vi-mode]} <= ${#plugins} )); then
  # VI specific settings

  bindkey jk vi-cmd-mode
  bindkey kj vi-cmd-mode

  rprompt_normal="%F{082}⮂%F{black}%K{082} NORMAL "
  rprompt_insert="%F{039}⮂%F{black}%K{039} INSERT "

  function zle-line-init
  {
    if (( ${+terminfo[smkx]} )); then
      printf '%s' ${terminfo[smkx]}
    fi
    zle zle-keymap-select
    zle reset-prompt
    zle -R
  }
  function zle-keymap-select
  {
    RPS1="${${KEYMAP/vicmd/${rprompt_normal}}/(main|viins)/${rprompt_insert}}%{$reset_color%}"
    RPS2=$RPS1
    zle reset-prompt
    zle -R
  }
  function zle-line-finish
  {
    if (( ${+terminfo[rmkx]} )); then
      printf '%s' ${terminfo[rmkx]}
    fi
    RPS1=" "
    RPS2=$RPS1
    zle reset-prompt
    zle -R
  }
  zle -N zle-line-init
  zle -N zle-line-finish
  zle -N zle-keymap-select

  function zle-isearch-update
  {
    # zle -M "Line $HISTNO"
    RPS1="${${KEYMAP/vicmd/${rprompt_normal}}/(main|viins)/${rprompt_insert}}${HISTNO} %{$reset_color%}"
    RPS2=$RPS1
    zle reset-prompt
    zle -R
  }
  zle -N zle-isearch-update

  function zle-isearch-exit
  {
    # zle -M ""
    RPS1=" "
    RPS2=$RPS1
    zle reset-prompt
    zle -R
  }
  zle -N zle-isearch-exit
else
  # We're using emacs bindings
  bindkey -e

  function zle-isearch-update
  {
    zle -M "Line $HISTNO $ZLE_STATE"
    # RPS1="%F{039}⮂%F{black}%K{039} SEARCH (glob) #${HISTNO} %{$reset_color%}"
    # RPS2=$RPS1
    # zle reset-prompt
    # zle -R
  }
  zle -N zle-isearch-update

  function zle-isearch-exit
  {
    zle -M ""
    # RPS1=" "
    # RPS2=$RPS1
    # zle reset-prompt
    # zle -R
  }
  zle -N zle-isearch-exit
fi

# Clear out syntax highlighting for history searching; it breaks things.
function history-incremental-pattern-search-backward { zle .history-incremental-pattern-search-backward }
function history-incremental-pattern-search-forward  { zle .history-incremental-pattern-search-forward }
zle -N history-incremental-pattern-search-backward
zle -N history-incremental-pattern-search-forward

bindkey '^P'  up-history
bindkey '^N'  down-history
bindkey '^W'  backward-kill-word
bindkey '^XR' history-incremental-search-backward
bindkey '^XS' history-incremental-search-forward
bindkey '^R'  history-incremental-pattern-search-backward
bindkey '^S'  history-incremental-pattern-search-forward

if (( ${keymaps[(i)isearch]} <= ${#keymaps} )); then
  bindkey -M isearch '^R' history-incremental-pattern-search-backward
  bindkey -M isearch '^S' history-incremental-pattern-search-forward
fi

# EOF
