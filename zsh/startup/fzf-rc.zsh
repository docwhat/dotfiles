# bindkey '^T' fzf-completion
# bindkey '^I' $fzf_default_completion

# Setup default options. Must be in the rc file, not env.
function {
  FZF_COMPLETION_TRIGGER='**'

  if (( ${+commands[rg]} )); then
    FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --hidden'
  elif (( ${+commands[ag]} )); then
    FZF_DEFAULT_COMMAND='ag --hidden -g'
  elif (( ${+commands[fd]} )); then
    FZF_DEFAULT_COMMAND='fd --type f'
  fi

  local -a fzf_default_opts
  fzf_default_opts=(
  '--color=fg:-1,bg:-1,hl:#ff8800,fg+:-1,bg+:#404040,hl+:#ffff00'
  '--color=info:#ddaaff,prompt:#88aadd,spinner:#88aa55,pointer:#dd5555,marker:#ffaa55'

  '--inline-info'
  '--bind=ctrl-k:kill-line'
  )

  local -a fzf_ctrl_r_opts
  fzf_ctrl_r_opts=(
  '--with-nth=2..'
  '--preview=echo {}'
  '--preview-window=down:3:hidden:wrap'
  '--bind=?:toggle-preview'
  '--bind=ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  '--header=Press CTRL-Y to copy command into clipboard'
  )

  # Enable FZF via TMUX pane
  if [ -n "$TMUX" ]; then
    FZF_TMUX=1
  else
    fzf_ctrl_r_opts+=( '--border' )
  fi

  FZF_CTRL_R_OPTS="${(@q-)fzf_ctrl_r_opts[@]}"
  FZF_DEFAULT_OPTS="${(@q-)fzf_default_opts[@]}"
}

#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
function fe() {
  local out file key
  local ed="${EDITOR:-vim}"
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e --header "Press CTRL-O to use open, Enter or CTRL-E to use ${ed}"))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    if [ "$key" = ctrl-o ]; then
      echo "Opening $file" 1>&2
      open "$file"
    else
      ${ed} "$file"
    fi
  fi
}

if (( ${+commands[fd]} )); then
  # Use fd (https://github.com/sharkdp/fd) instead of the default find
  # command for listing path candidates.
  # - The first argument to the function ($1) is the base path to start traversal
  # - See the source code (completion.{bash,zsh}) for the details.
  function _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  function _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi
