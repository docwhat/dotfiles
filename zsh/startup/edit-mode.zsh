# These break zsh-autosuggestions
# function zle-isearch-update { zle -M "Line $HISTNO" }
# zle -N zle-isearch-update

# function zle-isearch-exit { zle -M "" }
# zle -N zle-isearch-exit

bindkey '^P'  up-history
bindkey '^N'  down-history
bindkey '^W'  backward-kill-word

# I like pattern searches.
autoload -Uz narrow-to-region
function _history-incremental-preserving-pattern-search-backward
{
  local state
  MARK=CURSOR  # magick, else multiple ^R don't work
  narrow-to-region -p "$LBUFFER${BUFFER:+⁍ }" -P "${BUFFER:+ ⁌}$RBUFFER" -S state
  zle end-of-history
  zle history-incremental-pattern-search-backward
  narrow-to-region -R state
}
zle -N _history-incremental-preserving-pattern-search-backward
bindkey "^R" _history-incremental-preserving-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey -M isearch "^S" history-incremental-pattern-search-forward

# EOF
