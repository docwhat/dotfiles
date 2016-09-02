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

export PROMPT_EOL_MARK SHORT_HOST

# EOF
