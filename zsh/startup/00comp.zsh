# Create a cache directory if it doesn't exist.
if [ ! -d "${ZDOTDIR:-${HOME}}/.zsh/cache" ]; then
  mkdir -p "${ZDOTDIR:-${HOME}}/.zsh/cache"
fi

# Force starting compinit as early as possible
autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"

function compinit { }

# Complete aliases
setopt complete_aliases
