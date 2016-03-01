""" vim: set ft=python :
python << ENDPYTHON
# """
import vim
import os

cache_path = os.path.join(vim.vars['my_vim_dir'], '.plugin.check')

plugin_list = [
  "%s\t%s" %(n, d['uri'])
  for (n, d)
  in vim.eval('g:plugs').items()]
plugin_list.sort()

current_plugins = "\n".join(plugin_list) + "\n"
previous_plugins = ''

if os.path.exists(cache_path):
  with open(cache_path, 'r') as f:
    previous_plugins = f.read()

if previous_plugins != current_plugins:
  vim.vars['my_bootstrap'] = 1

  with open(cache_path, 'w') as f:
    f.write(current_plugins)

ENDPYTHON
