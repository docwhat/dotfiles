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
    lsd -1 --color=always --icon=always --tree "$realpath"
  elif [[ -f $realpath ]]; then
    bat -pp --color=always --line-range=:30 "$realpath"
  else
    exit
  fi
}
zstyle ":fzf-tab:complete:($(join_array \| exa lsd nvim vim vi cat bat rm cp mv icp imv less more)):*" fzf-preview "$functions[:tmp-fzf-preview]"
unfunction :tmp-fzf-preview
zstyle ":fzf-tab:complete:*" fzf-flags '--preview-window=right:50%:rounded'

zstyle ':fzf-tab:*:' prefix ''

# Load the plugin
zinit wait lucid light-mode for id-as"fzf-tab" has"fzf" @Aloxaf/fzf-tab
