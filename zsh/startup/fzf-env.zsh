# Add FZF to path
function {
  if ! [[ -d ~/.fzf ]]; then return; fi


  path=("${path[@]}" ~/.fzf/bin)

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

  manpath+=( ~/.fzf/man )
}
# vim: set ft=zsh :
