if [[ ! -d ~/.zsh ]]; then
  mkdir -p ~/.zsh
fi
HISTFILE=~/.zsh/history
SAVEHIST=50000
HISTSIZE=$((SAVEHIST * 1.20))

setopt HIST_BEEP
setopt EXTENDED_HISTORY
setopt NO_SHARE_HISTORY
setopt NO_INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt HIST_FCNTL_LOCK

# Don't automatically import new entries in the histfile. Use rehist instead.
alias rehist='fc -Ri'
