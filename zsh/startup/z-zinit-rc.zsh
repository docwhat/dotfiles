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

zinit wait lucid for \
  id-as"z.lua" \
  atclone'mkdir -p "$(dirname "$_ZL_DATA")"; touch "$_ZL_DATA"' \
  @skywind3000/z.lua

zinit wait lucid for \
  id-as"git-extras" \
  has"git" \
  src"etc/git-extras-completion.zsh" \
  atclone'make PREFIX=$ZPFX uninstall >/dev/null ; make PREFIX=$ZPFX <<(yes n)' \
  atpull'%atclone' \
  @tj/git-extras

zinit wait lucid for @chrissicool/zsh-256color

zinit wait lucid for @RobSis/zsh-completion-generator

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]='-i -d "${ZSH_COMPDUMP}"'; zicompinit; zicdreplay" \
  @zdharma-continuum/fast-syntax-highlighting

zinit wait lucid for @hlissner/zsh-autopair

zinit wait lucid for \
  atload"_zsh_autosuggest_start" \
  atload"_zsh_autosuggest_custom_config" \
  @zsh-users/zsh-autosuggestions

zinit wait lucid for \
  from"gh-r" \
  as"command" \
  mv"direnv* -> direnv" \
  pick"direnv" \
  atclone'./direnv hook zsh > zhook.zsh' \
  atpull'%atclone' \
  src="zhook.zsh" \
  @direnv/direnv

zinit wait lucid for \
  from"gh-r" \
  as"command" \
  mv'delta-* -> delta' \
  pick'delta/delta' \
  @dandavison/delta

# Must go before bat-extras
zinit wait lucid for \
  from"gh-r" \
  as"command" \
  atclone"mv shfmt* shfmt" \
  atpull'%atclone' \
  pick"shfmt" \
  @mvdan/sh

zinit wait lucid for \
  from"gh-r" \
  as"command" \
  mv"ripgrep-* -> rg" \
  pick"rg/rg" \
  @BurntSushi/ripgrep

zinit wait lucid for \
  id-as"gh" \
  from"gh-r" \
  as"program" \
  ver"latest" \
  has"git" \
  mv"gh* -> src" \
  atclone'src/bin/gh completion -s zsh > src/bin/_gh' \
  atpull'%atclone' \
  pick"src/bin/gh" \
  @cli/cli

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  mv"jq-* -> jq" \
  @stedolan/jq

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  mv'hadolint-* -> hadolint' \
  @hadolint/hadolint

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  mv"shellcheck* -> shellcheck" \
  pick"shellcheck/shellcheck" \
  @koalaman/shellcheck

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  pick"bat" \
  atclone'cp -f bat*/autocomplete/bat.zsh _bat' \
  atclone'cp -f bat*/bat bat' \
  atclone'ln -nsf "$PWD/bat"*/bat.1 "$ZINIT[MAN_DIR]/man1/bat.1"' \
  atpull'%atclone' \
  @sharkdp/bat

zinit wait lucid for \
  as"program" \
  pick"bin/*" \
  atclone'./build.sh --no-verify --minify=none --manuals --prefix "$ZPFX"' \
  atclone'ln -nsf "$PWD/man/"*.1 "$ZINIT[MAN_DIR]/man1/"' \
  atclone'ln -nsf "$PWD/bin/"* "$ZPFX/bin"' \
  atpull'%atclone' \
  atload'alias rg=batgrep' \
  atload'command -v less 2>/dev/null >&2 && alias man="MANPAGER=less batman"' \
  atload'eval "$(batpipe)"' \
  @eth-p/bat-extras

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  mv"fd-* -> files" \
  pick"files/fd" \
  atclone'mv files/fd.1 "$ZINIT[MAN_DIR]/man1/"' \
  atpull'%atclone' \
  @sharkdp/fd

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  mv"lsd* -> lsd" \
  pick"lsd/lsd" \
  @Peltoche/lsd

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  mv"exa* -> exa" \
  pick"bin/exa" \
  atload'alias ls="exa --icons --time-style=iso --git --classify --color-scale --color=auto"' \
  atload'alias ll="exa --icons --time-style=iso --git --classify --color-scale --color=auto --long -i --extended"' \
  atload'alias tree="exa --icons --time-style=iso --git --classify --color-scale --color=auto --tree"' \
  @ogham/exa

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  mv"docker-show-context* -> docker-show-context" \
  has"docker" \
  @pwaller/docker-show-context

zinit wait lucid for \
  from"gh-r" \
  as"program" \
  @gotestyourself/gotestsum

zinit wait lucid for \
  as"completion" \
  atpull'zinit creinstall -q "$PWD"' \
  atdelete"zinit cuninstall completions" \
  blockf \
  @zsh-users/zsh-completions

zinit wait lucid for \
  as"completion" \
  has"conda" \
  atload'eval "$(conda shell.zsh hook 2>/dev/null)"' \
  @esc/conda-zsh-completion

# macOS items
if [[ "${OSTYPE}" == darwin* ]]; then
  # Gets docker completion from Docker for Mac's files.
  zinit wait lucid for \
    id-as"docker-completion" \
    as"completion" \
    has"docker" \
    @chr-fritz/docker-completion.zshplugin
fi

zinit pack for 'ls_colors'

manpath=( $ZPFX/man "${manpath[@]}" )

# EOF
