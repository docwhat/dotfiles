# tabtab source for yarn package
yarn_completion="${HOME}/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh"

if [ -f "$yarn_completion" ]; then
  . "$yarn_completion"
fi
