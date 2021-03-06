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

function _zsh_autosuggest_custom_config {
  local -ra widgets_to_change=( forward-char vi-forward-char )

  ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:|widgets_to_change}
  ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=( "${widgets_to_change[@]}" )

  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"
  ZSH_AUTOSUGGEST_STRATEGY=( match_prev_cmd completion )
  ZSH_AUTOSUGGEST_USE_ASYNC=t
  ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c60,)|z *|zf *|cd *"
}

declare -a zinit_plugins=(
  id-as"z.lua"
  atclone'mkdir -p "$(dirname "$_ZL_DATA")"; touch "$_ZL_DATA"'
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

  id-as"autosuggestions"
  atload"_zsh_autosuggest_start"
  atload"_zsh_autosuggest_custom_config"
  @zsh-users/zsh-autosuggestions
)

declare -a zinit_programs=(
  id-as"direnv"
  from"gh-r"
  mv"direnv* -> direnv"
  atclone'./direnv hook zsh > zhook.zsh'
  atpull'%atclone'
  pick"direnv"
  src="zhook.zsh"
  @direnv/direnv

  id-as"delta"
  from"gh-r"
  mv'delta-* -> delta'
  pick'delta/delta'
  @dandavison/delta

  id-as"gh"
  from"gh-r"
  ver"latest"
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

  id-as"ripgrep"
  from"gh-r"
  mv"ripgrep* -> rg"
  pick"rg/rg"
  @BurntSushi/ripgrep

  id-as"bat"
  from"gh-r"
  mv"bat-* -> src"
  atclone'mkdir -p man/man1 bin'
  atclone'cp -f src/bat bin/bat'
  atclone'cp -f src/autocomplete/bat.zsh bin/_bat'
  atclone'cp -f src/*.1 man/man1/'
  atpull'%atclone'
  pick"bin/bat"
  atload'alias rg=batgrep'
  @sharkdp/bat

  id-as"bat-extras"
  atclone'./build.sh --prefix "$ZPFX" --install && mv man/*.1 "$ZPFX/share/man/man1"'
  atpull'%atclone'
  @eth-p/bat-extras

  id-as"fd"
  from"gh-r"
  mv"fd-* -> files"
  atclone'mkdir -p "$ZPFX/share/man/man1"'
  atclone'mv files/fd.1 "$ZPFX/share/man/man1/"'
  atpull'%atclone'
  pick"files/fd"
  @sharkdp/fd

  id-as"lsd"
  from"gh-r"
  mv"lsd* -> lsd"
  pick"lsd/lsd"
  @Peltoche/lsd

  id-as"exa"
  from"gh-r"
  mv"exa* -> exa"
  pick"bin/exa"
  atload'alias ls="exa --icons --time-style=iso --git --classify --color-scale --color=auto"'
  atload'alias ll="exa --icons --time-style=iso --git --classify --color-scale --color=auto --long -i --extended"'
  atload'alias tree="exa --icons --time-style=iso --git --classify --color-scale --color=auto --tree"'
  @ogham/exa

  id-as"docker-show-context"
  from"gh-r"
  mv"docker-show-context* -> docker-show-context"
  has"docker"
  @pwaller/docker-show-context

  id-as"gotestsum"
  from"gh-r"
  @gotestyourself/gotestsum
)

declare -a zinit_completion=(
  id-as"misc-completions"
  atpull'zinit creinstall -q "$PWD"'
  atdelete"zinit cuninstall completions"
  blockf
  @zsh-users/zsh-completions

  id-as"conda-completion"
  has"conda"
  atload'eval "$(conda shell.zsh hook 2>/dev/null)"'
  @esc/conda-zsh-completion
)

# macOS items
if [[ "${OSTYPE}" == darwin* ]]; then
  # Gets docker completion from Docker for Mac's files.
  zinit_plugins+=(
    id-as"docker-completion"
    has"docker"
    @chr-fritz/docker-completion.zshplugin
  )
fi

zinit wait'0a' lucid for "${zinit_plugins[@]}"

zinit wait'0b' lucid as"program" for "${zinit_programs[@]}"

zinit wait'0c' lucid as"completion" for "${zinit_completion[@]}"

zinit pack for @ls_colors

unset zinit_plugins

# EOF
