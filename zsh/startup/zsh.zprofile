if [ "$(locale charmap)" = "UTF-8" ]; then
  PROMPT_EOL_MARK='%K{yellow}%F{black}␄%k%b'
else
  PROMPT_EOL_MARK='%K{yellow}%F{black}%#%k%b'
fi

export PROMPT_EOL_MARK

# EOF
