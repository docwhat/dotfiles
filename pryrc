#!/usr/bin/env ruby
# frozen_string_literal: true

pry_goodies = []
pry_bummers = []

ruby_version =
  if defined? RUBY_VERSION && defined? RUBY_PATCHLEVEL
    "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
  elsif defined? RUBY_DESCRIPTION
    RUBY_DESCRIPTION.split(' ')[1].sub('p', '-p')
  else
    (`ruby -v` || '').split(' ')[1].sub('p', '-p')
  end

%w[
  hirb-unicode
  hirb
  pry-theme
].each do |gem|

  require gem
  pry_goodies << gem
rescue LoadError
  pry_bummers << gem
end

# Awesome print is nice at times.
AwesomePrint.pry! if defined? AwesomePrint

# Configuration
Pry.config.pager = true
Pry.config.color = true
Pry.config.editor = 'vim'
Pry.config.theme = 'pry-modern-256'

Pry.config.commands.instance_eval do
  alias_command 'h', 'hist --tail 20', desc: 'Last 20 commands'
end

# Ensure ~/.pry exists.
File.expand_path('~/.pry/history').tap do |history_file|
  dir = File.dirname(history_file)
  Dir.mkdir dir unless Dir.exist? dir
  Pry.config.history.file = history_file
end

# Welcome message.
Pry.hooks.add_hook(
  :before_session, 'pryrc_start_hook'
) do |output, _binding, _pry|
  output.print "Pry running on #{ruby_version} "
  output.print "with RubyGems #{Gem::VERSION} " if defined? Gem::VERSION
  output.puts "and #{pry_goodies.join ', '}."
  unless pry_bummers.empty?
    output.puts "Unable to load gems: #{pry_bummers.join ', '}"
  end
end

# Farewell message.
Pry.hooks.add_hook(
  :after_session, 'pryrc_start_hook'
) do |output, _binding, _pry|
  output.puts 'Buh-bye!'
end

# EOF
