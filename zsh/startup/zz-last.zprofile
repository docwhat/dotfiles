path=(~/bin ~/.bin "$path[@]")

# Fix the paths up
typeset -axU path manpath

# Load syntax highlighting last
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
if [ -r ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
