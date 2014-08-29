# vi: ft=ruby :

# Test Data
def toy(element)
  case element.to_s
  when /^a/i then (1..6).to_a
  when /^h/i then { fish: 'red', mouse: 'blue', prisoner: 6 }
  end
end

Pry.config.pager = true
Pry.config.color = true
Pry.config.editor = 'vim'
Pry.config.prompt = Pry::NAV_PROMPT
Pry.config.theme = 'solarized'
Pry.config.history.file = '~/.irb_history'

Pry.config.commands.instance_eval do
  alias_command 'h', 'hist --tail 20', desc: 'Last 20 commands'
end

%w(
  hirb-unicode
  hirb
  awesome_print
).each do |gem|
  begin
    require gem
  rescue LoadError => err
    puts "Bummer! No #{gem}: #{err}"
  end
end

Hirb.enable if defined? Hirb
AwesomePrint.pry! if defined? AwesomePrint

# EOF
