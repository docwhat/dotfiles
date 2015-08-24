# vi: ft=ruby :
# encoding: utf-8

PRY_GOODIES = []
PRY_BUMMERS = []

ruby_version = if defined? RUBY_VERSION && defined? RUBY_PATCHLEVEL
                 "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
               elsif defined? RUBY_DESCRIPTION
                 RUBY_DESCRIPTION.split(' ')[1].sub('p', '-p')
               else
                 (`ruby -v` || '').split(' ')[1].sub('p', '-p')
               end

%w(
  hirb-unicode
  hirb
  pry-theme
).each do |gem|
  begin
    require gem
    PRY_GOODIES << gem
  rescue LoadError
    PRY_BUMMERS << gem
  end
end

# Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
if defined? Hirb
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# Awesome print is nice at times.
AwesomePrint.pry! if defined? AwesomePrint

# Configuration
Pry.config.pager = true
Pry.config.color = true
Pry.config.editor = 'vim'
Pry.config.prompt = Pry::NAV_PROMPT
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
print "Pry running on #{ruby_version} "
print "with RubyGems #{Gem::VERSION} " if defined? Gem::VERSION
puts "and #{PRY_GOODIES.join ', '}."
puts "Unable to load gems: #{PRY_BUMMERS.join ', '}" unless PRY_BUMMERS.empty?

# EOF
