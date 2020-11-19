if ((${+functions[compinit]})); then
  # remove our dummy compinit
  unfunction compinit
fi

zinit light skywind3000/z.lua
zinit light tj/git-extras
zinit light chrissicool/zsh-256color
zinit light RobSis/zsh-completion-generator

zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]='-i -d "${ZSH_COMPDUMP}"'; zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions

# EOF
