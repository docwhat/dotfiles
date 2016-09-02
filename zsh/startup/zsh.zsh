function compute_host_completion
{
  local -a completions

  for i in /etc/ssh_config /etc/ssh/ssh_config ~/.ssh/config; do
    if [ -r "$i" ]; then
      completions=(${(@)completions} ${(z)${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}})
    fi
  done

  for i in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts ~/.ssh/known_hosts; do
    if [ -r "$i" ]; then
      completions=( \
        ${(@)completions} \
        ${${${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*}#\[}%\]*} \
        )
    fi
  done

  zstyle ':completion:*:*:*' hosts "${(@u)completions}"
}
compute_host_completion

alias reload='exec zsh -l'

# Overwrite Oh-My-Zsh's settings
zstyle ':completion:*'           use-cache on
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*'           cache-path ~/.zsh/cache
zstyle ':completion::complete:*' cache-path ~/.zsh/cache

zstyle ':completion:*' accept-exact '*(N)'

setopt dvorak

unsetopt correctall
setopt correct

alias copy-last-command='fc -l -n -1 -1 | tr -d "\n" | pbcopy'
if (( $+commands[resize] )); then
  alias resize='eval "$(\resize)"'
fi

# EOF
