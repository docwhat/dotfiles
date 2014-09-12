#!/usr/bin/env ruby

HOSTFILE = '/etc/hosts'

ip = ARGV.first

fail 'You need to pass in an ip address' unless ip =~ /\A[0-9.]+\Z/

original_hosts = File.read(HOSTFILE)
original_lines = original_hosts.split("\n").map(&:strip)

def domains
  resolv_conf = File.read('/etc/resolv.conf').split(/\n+/)
  domains = resolv_conf.grep(/^search\s(.*)$/)
  domains = resolv_conf.grep(/^domain\s(.*)$/) if domains.empty?
  return %w(home) if domains.empty?
  domains
    .first
    .split(/\s+/)
    .compact
    .tap(&:shift)
end

hosts = domains.map { |d| "boot2docker.#{d}" } + ['boot2docker']

new_lines = original_lines.reject { |l| l =~ /\sboot2docker\s*$/ }
new_lines << "#{ip}\t#{hosts.join ' '}"
new_hosts = new_lines.join("\n") + "\n"

if new_hosts != original_hosts
  puts "Updating #{HOSTFILE}..."
  begin
    File.open(HOSTFILE, 'w') { |f| f.write new_hosts }
  rescue Errno::EACCES
    puts "Permission denied. I would have written:\n#{new_hosts}"
  end
end

# EOF
