# Checks if the plugin list has changed.  If it has, then
# force a plugin update.

cache_path = File.expand_path '~/.config/nvim/.plugin.check'

current_plugins = VIM.evaluate('g:plugs').inspect
previous_plugins = File.readable?(cache_path) ? File.read(cache_path) : ''

if previous_plugins != current_plugins
  VIM.command 'let s:bootstrap=1'
  File.write(cache_path, current_plugins)
end
