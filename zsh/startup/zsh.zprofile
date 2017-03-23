# End-of-Line character
if [ "$(locale charmap)" = "UTF-8" ]; then
  PROMPT_EOL_MARK='%K{yellow}%F{black}␄%k%b'
else
  PROMPT_EOL_MARK='%K{yellow}%F{black}%#%k%b'
fi
export PROMPT_EOL_MARK

# Local man files
if [ -d ~/.local/share/man ]; then
  manpath=( "${manpath[@]}" ~/.local/share/man )
fi

# EOF
