autoload -U is-at-least

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
zstyle ':completion:*'           cache-path "${ZSH_CACHE_DIR}"
zstyle ':completion::complete:*' cache-path "${ZSH_CACHE_DIR}"

zstyle ':completion:*' accept-exact '*(N)'

setopt dvorak

unsetopt correctall
setopt correct

if is-at-least 5.1; then
  set zle_bracketed_paste  # Explicitly restore this zsh default
  autoload -Uz bracketed-paste-magic
  zle -N bracketed-paste bracketed-paste-magic
fi

if is-at-least 4.3; then
  typeset -ga zle_highlight
  zle_highlight=(
    isearch:underline
    paste:bg=34,fg=0
  )
fi

alias copy-last-command='fc -l -n -1 -1 | tr -d "\n" | pbcopy'
if (( ${+commands[resize]} )); then
  alias resize='eval "$(\resize)"'
fi

# Fixes paste being slow.
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# EOF
