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

zstyle ':completion:*'           use-cache on
zstyle ':completion:*'           cache-path "${ZSH_CACHE_DIR}"

zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'

function _set-list-colors() {
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	unfunction _set-list-colors
}
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact-dirs '*(/N)'

zstyle ':completion:*:functions' ignored-patterns '([@:+_/.-]*|pre(cmd|exec)|TRAP*)'

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
