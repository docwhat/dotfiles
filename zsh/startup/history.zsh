if [[ ! -d ~/.zsh ]]; then
  mkdir -p ~/.zsh
fi
HISTFILE=~/.zsh/history
HISTSIZE=50000
SAVEHIST=$(( $HISTSIZE - 200 )) # Give space for saving dups

setopt hist_beep        # Beep on history search errors
setopt no_share_history # Don't automatically import new entries in the histfile. Use rehist instead.

alias rehist='fc -Ri'
