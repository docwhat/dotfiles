if [[ ! -d ~/.zsh ]]; then
  mkdir -p ~/.zsh
fi
HISTFILE=~/.zsh/history
SAVEHIST=50000
HISTSIZE=$((SAVEHIST * 1.20))

setopt extendedhistory
setopt histbeep
setopt histfcntllock
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
setopt histverify
setopt incappendhistorytime
setopt noincappendhistory
setopt nosharehistory

# Don't automatically import new entries in the histfile. Use rehist instead.
alias rehist='fc -Ri'
