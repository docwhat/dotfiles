if (( ${+functions[compinit]} )); then
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
  @skywind3000/z.lua

  id-as"git-extras"
  has"git"
  src"etc/git-extras-completion.zsh"
  atclone'make PREFIX=$ZPFX uninstall >/dev/null ; make PREFIX=$ZPFX <<(yes n)'
  atpull'%atclone'
  @tj/git-extras
  # TODO: is it a bug that 'zi clist' does not show completions?

  id-as"256color"
  @chrissicool/zsh-256color

  id-as"completion-generator"
  @RobSis/zsh-completion-generator

  id-as"fast-syntax-highlighting"
  atinit"ZINIT[COMPINIT_OPTS]='-i -d "${ZSH_COMPDUMP}"'; zicompinit; zicdreplay"
  @zdharma/fast-syntax-highlighting

  id-as"zsh-autopair"
  @hlissner/zsh-autopair

  id-as"alias-tips"
  pick"alias-tips.plugin.zsh"
  atload'export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1'
  @djui/alias-tips

  id-as"autosuggestions"
  atload"_zsh_autosuggest_start"
  @zsh-users/zsh-autosuggestions

  id-as"completions"
  as"completion"
  atpull'zinit creinstall -q "$PWD"'
  atdelete"zinit cuninstall completions"
  blockf
  @zsh-users/zsh-completions
)

declare -a zinit_programs=(
  id-as"delta"
  from"gh-r"
  mv'delta-* -> delta'
  pick'delta/delta'
  @dandavison/delta

  id-as"gh"
  from"gh-r"
  has"git"
  mv"gh* -> src"
  atclone'src/bin/gh completion -s zsh > src/bin/_gh'
  atpull'%atclone'
  pick"src/bin/gh"
  @cli/cli

  id-as"jq"
  from"gh-r"
  mv"jq-* -> jq"
  as"program"
  @stedolan/jq

  id-as"shfmt"
  from"gh-r"
  atclone"mv shfmt* shfmt"
  atpull'%atclone'
  pick"shfmt"
  @mvdan/sh

  id-as"hadolint"
  from"gh-r"
  mv'hadolint-* -> hadolint'
  @hadolint/hadolint

  id-as"shellcheck"
  from"gh-r"
  mv"shellcheck* -> shellcheck"
  pick"shellcheck/shellcheck"
  @koalaman/shellcheck

  id-as"bat"
  from"gh-r"
  mv"bat-* -> src"
  atclone'mkdir -p man/man1 bin'
  atclone'cp -f src/bat bin/bat'
  atclone'cp -f src/autocomplete/bat.zsh bin/_bat'
  atclone'cp -f src/*.1 man/man1/'
  atpull'%atclone'
  pick"bin/bat"
  atload'alias less="bat"'
  @sharkdp/bat

  id-as"fd"
  from"gh-r"
  mv"fd-* -> files"
  atclone'mkdir -p "$ZPFX/share/man/man1"'
  atclone'mv files/fd.1 "$ZPFX/share/man/man1/"'
  atpull'%atclone'
  pick"files/fd"
  @sharkdp/fd

  id-as"bat-extras"
  atclone'./build.sh --prefix "$ZPFX" --install && mv man/*.1 "$ZPFX/share/man/man1"'
  atpull'%atclone'
  @eth-p/bat-extras

  id-as"lsd"
  from"gh-r"
  mv"lsd* -> lsd"
  pick"lsd/lsd"
  atload'alias ls="lsd"'
  @Peltoche/lsd
)

# macOS items
if [[ "${OSTYPE}" == darwin* ]]; then
  # Gets docker completion from Docker for Mac's files.
  zinit_plugins+=(
    id-as"docker-completion"
    chr-fritz/docker-completion.zshplugin
  )
fi

zinit wait'0a' lucid light-mode for "${zinit_plugins[@]}"

zinit wait'0b' lucid light-mode as"program" for "${zinit_programs[@]}"

unset zinit_plugins

# EOF
