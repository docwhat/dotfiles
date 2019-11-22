autoload -U is-at-least

ZPLUG_CACHE_DIR=~/.cache/zplug/
ZPLUG_REPOS=~/.cache/zplug-repos/

for _plugin_file in ~/.zsh/plugins/*.pre(UN); do
  source "$_plugin_file"
done

source "${HOME}/.zplug/init.zsh"

  for _plugin_file in ~/.zsh/plugins/*.plug(UN); do
    source "$_plugin_file"
  done

for _plugin_file in ~/.zsh/plugins/*.post(UN); do
  source "$_plugin_file"
done
unset _plugin_file

if ! zplug check; then
  zplug install
fi

zplug load

# EOF
