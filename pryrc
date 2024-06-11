#!/usr/bin/env ruby
# frozen_string_literal: true

ruby_version =
  if defined? RUBY_VERSION && defined? RUBY_PATCHLEVEL
    "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
  elsif defined? RUBY_DESCRIPTION
    RUBY_DESCRIPTION.split(" ")[1].sub("p", "-p")
  else
    (`ruby -v` || "").split(" ")[1].sub("p", "-p")
  end

# https://github.com/mmrwoods/dotfiles/blob/master/ruby/pryrc
def bundle(gem)
  return if Bundler.definition.current_dependencies.map(&:name).include?(gem)

  spec_path = Gem.path.map do |dir|
    Dir.glob("#{dir}/specifications/#{gem}-[0-9]*.gemspec").last
  end.compact.first
  return if spec_path.nil?

  spec = Gem::Specification.load(spec_path)
  $LOAD_PATH.concat(Dir.glob(spec.lib_dirs_glob))
  spec.runtime_dependencies.each do |dependency|
    bundle(dependency.name)
  end
end

# https://github.com/mmrwoods/dotfiles/blob/master/ruby/pryrc
def auto_require(lib, gem = lib)
  bundle(gem) if defined? Bundler
  require lib
rescue LoadError
  warn "#{__FILE__}: installing required gem '#{gem}'"
  system("gem install #{gem}")
  Gem.clear_paths
  bundle(gem) if defined? Bundler
  require lib
ensure
  yield if block_given?
end

auto_require "awesome_print"

auto_require "pry-doc"

auto_require "pry-theme" do
  Pry.config.theme = "pry-modern-256"
end

auto_require "hirb" do
  extend Hirb::Console
end

auto_require "hirb-unicode"

auto_require "pry-nav" do
  Pry::Commands.command(/^$/, "repeat last command") do
    _pry_.run_command Pry.history.to_a.last
  end
end

# auto_require 'pry-byebug' do
#   Pry.commands.alias_command 'c', 'continue'
#   Pry.commands.alias_command 's', 'step'
#   Pry.commands.alias_command 'n', 'next'
#   Pry.commands.alias_command 'f', 'finish'
#   Pry::Commands.command(/^$/, 'repeat last command') do
#     _pry_.run_command Pry.history.to_a.last
#   end
# end

# Configuration
Pry.config.pager = true
Pry.config.color = true
Pry.config.editor = "vim"

Pry.config.commands.instance_eval do
  alias_command "h", "hist --tail 20", desc: "Last 20 commands"
end

# Welcome message.
Pry.hooks.add_hook(
  :before_session, "pryrc_start_hook"
) do |output, _binding, _pry|
  output.print "Pry running on #{ruby_version} "
  output.print "with RubyGems #{Gem::VERSION} " if defined? Gem::VERSION
  output.print "\n"
end

# Farewell message.
Pry.hooks.add_hook(
  :after_session, "pryrc_start_hook"
) do |output, _binding, _pry|
  output.puts "Buh-bye!"
end

# EOF
