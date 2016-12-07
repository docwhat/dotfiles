# vim: set ft=zsh :

# Figure out the SHORT hostname
if [ -n "$commands[scutil]" ]; then
  # OS X
  SHORT_HOST=$(scutil --get ComputerName)
  SHORT_HOST="${SHORT_HOST%% \(*\)}"
else
  SHORT_HOST=${HOST/.*/}
fi
export SHORT_HOST

# Save the location of the current completion dump file.
# Forces oh-my-zsh to use this location.
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zsh/cache/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
ZGEN_CUSTOM_COMPDUMP=$ZSH_COMPDUMP
