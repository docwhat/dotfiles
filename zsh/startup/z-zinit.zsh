if ((${+functions[compinit]})); then
  # remove our dummy compinit
  unfunction compinit
fi

declare -a zinit_plugins=(
  id-as"z.lua"
  has"lua"
  skywind3000/z.lua

  id-as"git-extras"
  has"git"
  src"etc/git-extras-completion.zsh"
  make"PREFIX=$ZPFX"
  tj/git-extras
  # TODO: is it a bug that 'zi clist' does not show completions?

  id-as"256color"
  chrissicool/zsh-256color

  id-as"completion-generator"
  RobSis/zsh-completion-generator

  id-as"fast-syntax-highlighting"
  atinit"ZINIT[COMPINIT_OPTS]='-i -d "${ZSH_COMPDUMP}"'; zicompinit; zicdreplay"
  zdharma/fast-syntax-highlighting

  id-as"autosuggestions"
  atload"_zsh_autosuggest_start"
  zsh-users/zsh-autosuggestions

  id-as"completions"
  atpull'zinit creinstall -q .'
  blockf
  zsh-users/zsh-completions
)

# macOS items
if [[ "${OSTYPE}" == darwin* ]]; then
  # Gets docker completion from Docker for Mac's files.
  zinit_plugins+=(
    id-as"docker-completion"
    chr-fritz/docker-completion.zshplugin
  )
fi

zinit wait lucid light-mode for "${zinit_plugins[@]}"

unset zinit_plugins

function from-where {
  echo "Completion used:"
  whence -v $_comps[$1] | offset
  echo "Candidate completions:"
  print -l $^fpath/$_comps[$1](N) | offset
}


# EOF
