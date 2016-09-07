# Create a cache directory if it doesn't exist.
if [ ! -d "${ZDOTDIR:-${HOME}}/.zsh/cache" ]; then
  mkdir -p "${ZDOTDIR:-${HOME}}/.zsh/cache"
fi

# Save the location of the current completion dump file.
# Forces oh-my-zsh to use this location.
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zsh/cache/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
ZGEN_CUSTOM_COMPDUMP=$ZSH_COMPDUMP

# Force starting compinit as early as possible
autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"

function compinit { }
