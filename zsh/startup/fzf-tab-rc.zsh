join_array() {
  local -r delimiter=$1
  local output=$2
  for param in "${@:3}"; do
    output="${output}${delimiter}${param}"
  done
  echo "${output}"
}

:tmp-fzf-preview() {
  if [[ -r $realpath ]]; then
    file --brief "$realpath"
  fi
  if [[ -d $realpath ]]; then
    if (( ${+commands[eza]} )); then
      eza --color=always --icons --classify --tree "$realpath"
    elif (( ${+commands[exa]} )); then
      exa --color=always --icons --classify --tree "$realpath"
    elif (( ${+commands[lsd]} )); then
      lsd -1 --color=always --icon=always --tree "$realpath"
    elif (( ${+commands[tree]} )); then
      tree "$realpath"
    else
      ls "$realpath"
    fi
  elif [[ -f $realpath ]]; then
    bat -pp --color=always --line-range=:30 "$realpath"
  else
    exit
  fi
}

declare -ra cmds=(
bat
cat
cd
cp
exa
emacs
icp
imv
less
lsd
more
mv
nvim
rm
vi
vim
)

zstyle ":fzf-tab:complete:($(join_array \| "${cmds[@]}" )):*" fzf-preview "$functions[:tmp-fzf-preview]"
unfunction :tmp-fzf-preview
zstyle ":fzf-tab:complete:*" fzf-flags '--preview-window=right:50%:rounded'

zstyle ':fzf-tab:*:' prefix ''

# EOF
