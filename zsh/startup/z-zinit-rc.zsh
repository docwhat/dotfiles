if (( ${+functions[compinit]} )); then
  # remove our dummy compinit
  unfunction compinit
fi

function from-where {
local candidate
  echo "Completion used:"
  whence -v $_comps[$1] | offset
  echo "Candidate completions:"
  for candidate in $^fpath/$_comps[$1](N^/); do
    echo -n "  "
    if (( ${+commands[exa]} )); then
      exa --long --no-permissions --no-filesize --no-user --no-time "$candidate"
    else
      ls -l "$candidate"
    fi
  done
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

zinit wait lucid light-mode for \
  has'docker' \
  as"completion" \
  id-as"docker-completion/_docker" \
  nocompile \
  is-snippet \
  '@https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker'

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode id-as'auto' for \
  '@zdharma-continuum/zinit-annex-as-monitor' \
  '@zdharma-continuum/zinit-annex-bin-gem-node' \
  '@zdharma-continuum/zinit-annex-patch-dl' \
  '@zdharma-continuum/zinit-annex-rust'

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
  as'program' \
  mv'direnv* -> direnv' \
  pick'direnv' \
  atclone'./direnv hook zsh > zhook.zsh' \
  atpull'%atclone' \
  src'zhook.zsh' \
  id-as'auto' \
  @direnv/direnv

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'delta-* -> delta' \
  pick'delta/delta' \
  id-as'auto' \
  @dandavison/delta

# Must go before bat-extras
zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  atclone'mv shfmt* shfmt' \
  atpull'%atclone' \
  pick'shfmt' \
  id-as'shfmt' \
  @mvdan/sh

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  pick'rg' \
  id-as'rg' \
  @microsoft/ripgrep-prebuilt

zinit wait lucid light-mode for \
  from'gh-r' \
  as'completion' \
  nocompile \
  mv'ripgrep-* -> ripgrep' \
  atclone'ln -nsf "$PWD"/ripgrep/doc/rg.1 "$ZINIT[MAN_DIR]/man1/rg.1"' \
  atpull'%atclone' \
  id-as'rg-man' \
  @BurntSushi/ripgrep

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  has'git' \
  mv'gh* -> src' \
  atclone'src/bin/gh completion -s zsh > src/bin/_gh' \
  atpull'%atclone' \
  pick'src/bin/gh' \
  id-as'gh' \
  @cli/cli

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'jq-* -> jq' \
  id-as'auto' \
  @jqlang/jq

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
  id-as'auto' \
  @sharkdp/bat

zinit wait lucid light-mode for \
  as'program' \
  pick'bin/*' \
  atclone'./build.sh --no-verify --minify=none --manuals --prefix "$ZPFX"' \
  atclone'ln -nsf "$PWD/man/"*.1 "$ZINIT[MAN_DIR]/man1/"' \
  atclone'ln -nsf "$PWD/bin/"* "$ZPFX/bin"' \
  atpull'%atclone' \
  atload'eval "$(batpipe)"' \
  atload'alias rg=batgrep ; zicompdef _rg batgrep' \
  atload'alias man=batman ; zicompdef _man batman' \
  id-as'auto' \
  @eth-p/bat-extras

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'fd-* -> files' \
  pick'files/fd' \
  atclone'ln -svf "$PWD/files/"*.1 "$ZINIT[MAN_DIR]/man1/"' \
  atpull'%atclone' \
  id-as'auto' \
  @sharkdp/fd

zinit wait lucid light-mode \
    from'gh-r' \
    id-as'auto' \
    nocompile \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-tmux' \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> completion.zsh' \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh' \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> man/fzf-tmux.1' \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> man/fzf.1' \
    atclone'mkdir -p $ZPFX/{bin,man/man1}' \
    atclone'ln -nsvf "$PWD/man/"*.1 "${ZINIT[MAN_DIR]}/man1"' \
    atpull'%atclone' \
    pick'/dev/null' \
    sbin'fzf' \
    sbin'fzf-tmux' \
    multisrc'key-bindings.zsh' \
    multisrc'completion.zsh' \
  for @junegunn/fzf


zinit wait lucid light-mode for id-as'auto' has'fzf' @Aloxaf/fzf-tab

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'lsd* -> lsd' \
  pick'lsd/lsd' \
  atclone'ln -svf "$PWD/lsd/"*.1 "${ZINIT[MAN_DIR]}/man1"' \
  id-as'auto' \
  @lsd-rs/lsd

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  pick'bin/exa' \
  atclone'ln -nsvf "$PWD/man/"*.1 "${ZINIT[MAN_DIR]}/man1"' \
  atclone'ln -nsvf "$PWD/man/"*.5 "${ZINIT[MAN_DIR]}/man5"' \
  atclone'ln -nsvf "$PWD/completions/exa.zsh" "${ZINIT[COMPLETIONS_DIR]}/_exa"' \
  atload'alias ls="exa --icons --time-style=iso --git --classify --color-scale --color=auto"' \
  atload'alias ll="exa --icons --time-style=iso --git --classify --color-scale --color=auto --long -i --extended"' \
  atload'alias tree="exa --icons --time-style=iso --git --classify --color-scale --color=auto --tree"' \
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

zinit wait lucid light-mode for \
  has'kubectl' \
  pick'/dev/null' \
  sbin'kubectx' \
  sbin'kubens' \
  atclone'ln -sf completion/_kubectx.zsh _kubectx; ln -sf completion/_kubens.zsh _kubens' \
  atpull'%atclone' \
  @ahmetb/kubectx

zinit wait lucid light-mode for \
  has'lua' \
  has'node' \
  from'gh-r' \
  sbin'**/nvim' \
  id-as'auto' \
  @neovim/neovim

zinit wait lucid light-mode for \
  id-as'auto' \
  @olets/zsh-window-title
export ZSH_WINDOW_TITLE_DIRECTORY_DEPTH=${ZSH_WINDOW_TITLE_DIRECTORY_DEPTH:-1}

zinit wait pack light-mode for 'ls_colors'

zinit wait lucid light-mode for \
  as'completion' \
  has'nix-env' \
  id-as'auto' \
  @spwhitt/nix-zsh-completions

# EOF
