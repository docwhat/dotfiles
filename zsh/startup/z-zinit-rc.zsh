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

declare -A _bpicks=()
if [[ $OSTYPE == darwin* ]] && [[ $CPUTYPE == arm* ]]; then
  _bpicks[rust]='*(x86_64|arm)*darwin*'
  _bpicks[haskell]='*darwin*(x86_64|arm)*'
  _bpicks[jq]='*osx*(amd64|arm)*'
  _bpicks[gh]='*macos*(amd64|arm)*'
  _bpicks[exa]='*macos*(x86_64|arm)*'
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode id-as'auto' for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit wait lucid light-mode for \
  has'lua' \
  atclone'mkdir -p "$(dirname "$_ZL_DATA")"; touch "$_ZL_DATA"' \
  id-as'auto' \
  @skywind3000/z.lua

zinit wait lucid light-mode for \
  has'git' \
  src'etc/git-extras-completion.zsh' \
  atclone'make PREFIX=$ZPFX uninstall >/dev/null ; make PREFIX=$ZPFX <<(yes n)' \
  atpull'%atclone' \
  id-as'auto' \
  @tj/git-extras

zinit wait lucid light-mode for \
  id-as'auto' \
  @chrissicool/zsh-256color

zinit wait lucid light-mode for \
  id-as'auto' \
  @RobSis/zsh-completion-generator

zinit wait lucid light-mode for \
  atinit'ZINIT[COMPINIT_OPTS]="-i -d ${(qq)ZSH_COMPDUMP}"; zicompinit; zicdreplay' \
  id-as'auto' \
  @zdharma-continuum/fast-syntax-highlighting

zinit wait lucid light-mode for \
  id-as'auto' \
  @hlissner/zsh-autopair

zinit wait lucid light-mode for \
  atload'_zsh_autosuggest_start' \
  atload'_zsh_autosuggest_custom_config' \
  id-as'auto' \
  @zsh-users/zsh-autosuggestions

zinit wait lucid light-mode for \
  from'gh-r' \
  as'command' \
  mv'direnv* -> direnv' \
  pick'direnv' \
  atclone'./direnv hook zsh > zhook.zsh' \
  atpull'%atclone' \
  src='zhook.zsh' \
  id-as'auto' \
  @direnv/direnv

zinit wait lucid light-mode for \
  from'gh-r' \
  as'command' \
  mv'delta-* -> delta' \
  pick'delta/delta' \
  --bpick="$_bpicks[rust]" \
  id-as'auto' \
  @dandavison/delta

# Must go before bat-extras
zinit wait lucid light-mode for \
  from'gh-r' \
  as'command' \
  atclone'mv shfmt* shfmt' \
  atpull'%atclone' \
  pick'shfmt' \
  id-as'shfmt' \
  @mvdan/sh

zinit wait lucid light-mode for \
  from"gh-r" \
  as"command" \
  mv"ripgrep-* -> rg" \
  pick"rg/rg" \
  atclone'ln -nsf "$PWD"/rg*/doc/rg.1 "$ZINIT[MAN_DIR]/man1/rg.1"' \
  atpull'%atclone' \
  --bpick="$_bpicks[rust]" \
  id-as'rg' \
  @BurntSushi/ripgrep

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  ver'latest' \
  has'git' \
  mv'gh* -> src' \
  atclone'src/bin/gh completion -s zsh > src/bin/_gh' \
  atpull'%atclone' \
  pick'src/bin/gh' \
  --bpick="$_bpicks[gh]" \
  id-as'gh' \
  @cli/cli

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'jq-* -> jq' \
  id-as'auto' \
  --bpick="$_bpicks[jq]" \
  @stedolan/jq

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'hadolint-* -> hadolint' \
  id-as'auto' \
  @hadolint/hadolint

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  has'xz' \
  mv'shellcheck* -> shellcheck' \
  pick'shellcheck/shellcheck' \
  --bpick="$_bpicks[haskell]" \
  id-as'auto' \
  @koalaman/shellcheck

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  pick'bat' \
  atclone'cp -f bat*/autocomplete/bat.zsh _bat' \
  atclone'cp -f bat*/bat bat' \
  atclone'ln -nsf "$PWD/bat"*/bat.1 "$ZINIT[MAN_DIR]/man1/bat.1"' \
  atpull'%atclone' \
  --bpick="$_bpicks[rust]" \
  id-as'auto' \
  @sharkdp/bat

zinit wait lucid light-mode for \
  as'program' \
  pick'bin/*' \
  atclone'./build.sh --no-verify --minify=none --manuals --prefix "$ZPFX"' \
  atclone'ln -nsf "$PWD/man/"*.1 "$ZINIT[MAN_DIR]/man1/"' \
  atclone'ln -nsf "$PWD/bin/"* "$ZPFX/bin"' \
  atpull'%atclone' \
  atload'alias rg=batgrep && compdef _rg batgrep' \
  atload'command -v less 2>/dev/null >&2 && alias man="MANPAGER=less batman" && compdef _man batman' \
  atload'eval "$(batpipe)"' \
  id-as'auto' \
  @eth-p/bat-extras

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'fd-* -> files' \
  pick'files/fd' \
  atclone'mv files/fd.1 "$ZINIT[MAN_DIR]/man1/"' \
  atpull'%atclone' \
  --bpick="$_bpicks[rust]" \
  id-as'auto' \
  @sharkdp/fd

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'lsd* -> lsd' \
  pick'lsd/lsd' \
  --bpick="$_bpicks[rust]" \
  id-as'auto' \
  @Peltoche/lsd

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  pick'bin/exa' \
  atload'alias ls="exa --icons --time-style=iso --git --classify --color-scale --color=auto"' \
  atload'alias ll="exa --icons --time-style=iso --git --classify --color-scale --color=auto --long -i --extended"' \
  atload'alias tree="exa --icons --time-style=iso --git --classify --color-scale --color=auto --tree"' \
  --bpick="$_bpicks[exa]" \
  id-as'auto' \
  @ogham/exa

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'docker-show-context* -> docker-show-context' \
  has'docker' \
  id-as'auto' \
  @pwaller/docker-show-context

zinit wait'[[ -f go.mod ]] || { g=( *.go([1]N) ) && [[ -f $g ]] } || [[ -n ${ZLAST_COMMANDS[(r)gotest*]} ]]' lucid light-mode for \
  from'gh-r' \
  as'program' \
  id-as'auto' \
  @gotestyourself/gotestsum

# atpull'zinit creinstall -q "$PWD"'
zinit wait lucid light-mode for \
  as'completion' \
  atdelete'zinit cuninstall completions' \
  atload"zicompinit; zicdreplay" \
  blockf \
  id-as'auto' \
  @zsh-users/zsh-completions

zinit wait lucid light-mode for \
  as'completion' \
  has'conda' \
  atload'eval "$(conda shell.zsh hook 2>/dev/null)"' \
  id-as'auto' \
  @esc/conda-zsh-completion

zinit pack light-mode for 'ls_colors'

manpath=( $ZPFX/man "${manpath[@]}" )

# EOF
