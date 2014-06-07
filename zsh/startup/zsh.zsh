function reload
{
  for rcfile in zshenv zprofile zshrc zlogin; do
    if [[ -r ~/.${rcfile} ]]; then
      echo "reloading ${rcfile}..." 1>&2
      source ~/.${rcfile}
    fi
  done
}

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH/cache"
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZSH/cache"

setopt dvorak

unsetopt correctall
setopt correct

alias copy-last-command='fc -l -n -1 -1 | tr -d "\n" | pbcopy'

# EOF
