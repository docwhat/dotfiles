if ((${+functions[compinit]})); then
  # remove our dummy compinit
  unfunction compinit
fi

function from-where {
  echo "Completion used:"
  whence -v $_comps[$1] | offset
  echo "Candidate completions:"
  print -l $^fpath/$_comps[$1](N) | offset
}

declare -a zinit_plugins=(
  id-as"z.lua"
  has"lua"
  @skywind3000/z.lua

  id-as"git-extras"
  has"git"
  src"etc/git-extras-completion.zsh"
  make"PREFIX=$ZPFX"
  @tj/git-extras
  # TODO: is it a bug that 'zi clist' does not show completions?

  id-as"256color"
  @chrissicool/zsh-256color

  id-as"completion-generator"
  @RobSis/zsh-completion-generator

  id-as"shfmt"
  as"program"
  from"gh-r"
  mv'shfmt* -> $ZPFX/bin/shfmt'
  @mvdan/sh

  id-as"fast-syntax-highlighting"
  atinit"ZINIT[COMPINIT_OPTS]='-i -d "${ZSH_COMPDUMP}"'; zicompinit; zicdreplay"
  @zdharma/fast-syntax-highlighting

  id-as"zsh-autopair"
  @hlissner/zsh-autopair

  id-as"alias-tips"
  pick"alias-tips.plugin.zsh"
  atload'export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1'
  @djui/alias-tips

  id-as"fzf-tab"
  has"fzf"
  atload"zstyle ':fzf-tab:complete:cd:*' fzf-preview --height=100% 'lsd -1 --color=always $realpath'"
  @Aloxaf/fzf-tab

  id-as"bat"
  as"program"
  from"gh-r"
  mv"bat-* -> files"
  atclone'mkdir -p "$ZPFX/share/man/man1/"'
  atclone'mv files/bat.1 "$ZPFX/share/man/man1/"'
  atclone'mv files/autocomplete/bat.zsh _bat'
  atpull'%atclone'
  pick"files/bat"
  atload'alias less="bat"'
  @sharkdp/bat

  id-as"fd"
  as"program"
  from"gh-r"
  mv"fd-* -> files"
  atclone'mkdir -p "$ZPFX/share/man/man1"'
  atclone'mv files/fd.1 "$ZPFX/share/man/man1/"'
  atpull'%atclone'
  pick"files/fd"
  @sharkdp/fd

  id-as"bat-extras"
  as"program"
  atclone'./build.sh --prefix "$ZPFX" --install && mv man/*.1 "$ZPFX/share/man/man1"'
  atpull'%atclone'
  @eth-p/bat-extras

  id-as"lsd"
  as"program"
  from"gh-r"
  mv"lsd* -> lsd"
  pick"lsd/lsd"
  atload'alias ls="lsd"'
  @Peltoche/lsd

  id-as"autosuggestions"
  atload"_zsh_autosuggest_start"
  @zsh-users/zsh-autosuggestions

  id-as"completions"
  atpull'zinit creinstall -q .'
  blockf
  @zsh-users/zsh-completions
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

# EOF
