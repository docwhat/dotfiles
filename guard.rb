# encoding: UTF-8

# notification :tmux, color_location: 'status-right-bg'
notification :tmux, color_location: 'status-left-fg'
# display_message: true,
# success: '#00ff00',
# pending: '#ffff00',
# failed: '#ff0000',
# default: '#0088ff',

notification :terminal_notifier

begin
  require 'guard/shell'
  guard :shell do
    watch(%r{^(?:app|lib)/.+\.rb$}) { `ctags -R --languages=Ruby`  }
  end
rescue LoadError
  puts "Hey, Christian! Add 'guard-shell' to your Gemfile. (from ~/.guard.rb)"
end
