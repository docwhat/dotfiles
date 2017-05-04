autoload -U is-at-least
ZGEN_RESET_ON_CHANGE=(
"${HOME}/.zsh/startup/0plugins.zsh"
"${HOME}/.zsh/startup/0plugins.zshenv"
"${HOME}/.zsh/plugins/"*(UN)
)
source "${HOME}/.zgen/zgen.zsh"

for _plugin_file in ~/.zsh/plugins/*.pre(UN); do
  source "$_plugin_file"
done

if ! zgen saved; then
  for _plugin_file in ~/.zsh/plugins/*.zgen(UN); do
    source "$_plugin_file"
  done

  # Save it all to init script
  zgen save
fi

for _plugin_file in ~/.zsh/plugins/*.post(UN); do
  source "$_plugin_file"
done
unset _plugin_file

# EOF
