# Checks if the plugin list has changed.  If it has, then
# force a plugin update.

require 'json'

# Class to hold plugins
class Plugins
  def initialize
    @plugins = VIM.evaluate 'g:plugs'
  end

  def to_json
    JSON.pretty_generate(@plugins) + "\n"
  end

  def data_home
    @data_home ||= File.expand_path(
      VIM.evaluate('g:xdg_data_home') || '~/.config/nvim'
    )
  end

  def filename
    @filename ||= File.join(data_home, 'plugins.json')
  end

  def previous_json
    @previous_json ||= File.readable?(filename) ? File.read(filename) : ''
  end

  def changed?
    return true if previous_json != to_json
    @plugins.each_pair do |_name, data|
      return true unless File.directory? data['dir']
    end
    false
  end

  def write!
    File.write(filename, to_json)
  end
end

Plugins.new.tap do |plugins|
  if plugins.changed?
    VIM.command 'let s:bootstrap=1'
    plugins.write!
  end
end
