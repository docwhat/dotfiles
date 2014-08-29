# vi: ft=ruby :

# Test Data
TEST_DATA = {
  array: -> { (1..6).to_a },
  hash: -> { { fish: 'red', mouse: 'blue', prisoner: 6 } }
}

def toy(element = nil)
  help_message = [
    'I can make test data for you:',
    TEST_DATA.keys.map { |l| " * #{l}" }
  ].flatten.join("\n")
  TEST_DATA.fetch(element) do
    -> { puts help_message }
  end.call
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
