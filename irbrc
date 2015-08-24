# vim: ft=ruby :
# encoding: utf-8

require 'rubygems' unless defined? Gem # Old rubygems.

IRB_GOODIES = []
IRB_BUMMERS = []

%w(
  irbtools/configure
  boson/console
).each do |gem|
  begin
    require gem
    IRB_GOODIES << gem
  rescue LoadError
    IRB_BUMMERS << gem
  end
end

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = File.expand_path '~/.irb_history'
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:USE_READLINE] = true

ruby_version = if defined? RUBY_VERSION && defined? RUBY_PATCHLEVEL
                 "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
               elsif defined? RUBY_DESCRIPTION
                 RUBY_DESCRIPTION.split(' ')[1].sub('p', '-p')
               else
                 (`ruby -v` || '').split(' ')[1].sub('p', '-p')
               end

IRB.conf[:PROMPT] ||= {}
IRB.conf[:PROMPT][:DOCWHAT] = {          #  name of prompt mode
  PROMPT_I: "#{ruby_version} :%03n > ",  #  normal prompt
  PROMPT_S: "#{ruby_version} :%03n%l> ", #  prompt for continuated strings
  PROMPT_C: "#{ruby_version} :%03n > ",  #  prompt for continuated statement
  PROMPT_N: "#{ruby_version} :%03n?> ",  #  prompt for unknown continuation
  RETURN: " => %s \n",                   #  format to return value
  AUTO_INDENT: true
}
IRB.conf[:PROMPT_MODE] = :DOCWHAT

# Awesome print is nice at times.
AwesomePrint.irb! if defined? AwesomePrint

if defined? Pry
  Pry.start
  exit!
elsif defined? Irbtools
  Irbtools.add_package :more
  Irbtools.start
else
  # Welcome message.
  print "Irb running on #{RUBY_DESCRIPTION} "
  print "with RubyGems #{Gem::VERSION} " if defined? Gem::VERSION
  puts "and #{IRB_GOODIES.join ', '}."
  puts "Unable to load gems: #{IRB_BUMMERS.join ', '}" unless IRB_BUMMERS.empty?
end

# EOF
