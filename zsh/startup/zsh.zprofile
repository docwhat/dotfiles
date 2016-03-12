# vim: set ft=zsh :

if [ "$(locale charmap)" = "UTF-8" ]; then
  PROMPT_EOL_MARK='%K{yellow}%F{black}␄%k%b'
else
  PROMPT_EOL_MARK='%K{yellow}%F{black}%#%k%b'
fi

# Figure out the SHORT hostname
if [ -n "$commands[scutil]" ]; then
  # OS X
  SHORT_HOST=$(scutil --get ComputerName)
  SHORT_HOST="${SHORT_HOST%% \(*\)}"
else
  SHORT_HOST=${HOST/.*/}
fi

# Create a cache directory if it doesn't exist.
if [ ! -d "${ZDOTDIR:-${HOME}}/.zsh/cache" ]; then
  mkdir -p "${ZDOTDIR:-${HOME}}/.zsh/cache"
fi

# Save the location of the current completion dump file.
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zsh/cache/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

export PROMPT_EOL_MARK ZSH_COMPDUMP SHORT_HOST
# EOF
