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
    if (( ${+commands[eza]} )); then
      eza --long --no-permissions --no-filesize --no-user --no-time "$candidate"
    elif (( ${+commands[exa]} )); then
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

# This plugin conflicts with Amazon Q.
if [[ -z ${Q_TERM:-} ]]; then
  zinit wait lucid light-mode for \
    atload'_zsh_autosuggest_start' \
    atload'_zsh_autosuggest_custom_config' \
    id-as'auto' \
    @zsh-users/zsh-autosuggestions
fi

zinit wait lucid light-mode for id-as'auto' has'fzf' @Aloxaf/fzf-tab

zinit wait lucid light-mode for \
  from'gh-r' \
  as'program' \
  mv'docker-show-context* -> docker-show-context' \
  has'docker' \
  id-as'auto' \
  @pwaller/docker-show-context

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
