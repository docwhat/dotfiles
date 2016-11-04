# These break zsh-autosuggestions
# function zle-isearch-update { zle -M "Line $HISTNO" }
# zle -N zle-isearch-update

# function zle-isearch-exit { zle -M "" }
# zle -N zle-isearch-exit

bindkey '^P'  up-history
bindkey '^N'  down-history
bindkey '^W'  backward-kill-word

# I like pattern searches.
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey -M isearch "^S" history-incremental-pattern-search-forward

# EOF
