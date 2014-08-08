#!/usr/bin/env ruby

HOSTFILE = '/etc/hosts'

ip = ARGV.first

original_hosts = File.read(HOSTFILE)
original_lines = original_hosts.split("\n").map(&:strip)

new_lines = original_lines.reject { |l| l =~ /\sboot2docker\s*$/ }
new_lines << "#{ip}\tboot2docker"
new_hosts = new_lines.join("\n") + "\n"

if new_hosts != original_hosts
  puts "Updating #{HOSTFILE}..."
  File.open(HOSTFILE, 'w') { |f| f.write new_hosts }
end

# EOF
