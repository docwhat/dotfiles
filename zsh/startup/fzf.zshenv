
if [ -d /usr/local/opt/fzf/bin ]; then
  fzf_base_dir=/usr/local/opt/fzf
elif [ -d ~/.fzf/bin ]; then
  fzf_base_dir=~/.fzf
fi
export fzf_base_dir

if [ -n "$fzf_base_dir" ] && ! (( $+commands[fzf] )); then
  path=("${path[@]}" "${fzf_base_dir}/bin")
fi
