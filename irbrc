# vim: ft=ruby :
# encoding: utf-8

require 'rubygems' unless defined? Gem # Old rubygems.

if Gem::Version.new(Gem::VERSION) < Gem::Version.new('2.1')
  puts 'You probably want update to rubygems 2.1 or newer:'
  puts '  gem update --system'
  puts '  gem pristine --all'
end

begin
  require 'pry'
  puts "Welcome to PRY. You are using #{RUBY_DESCRIPTION} with RubyGems #{Gem::VERSION}. Have fun ;)"
  Pry.start
  exit
rescue LoadError
  require 'irbtools/configure'
  begin
    require 'boson/console'
  rescue LoadError
    true
  end
  Irbtools.add_package :more
  Irbtools.start
end
