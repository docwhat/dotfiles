#!/usr/bin/env ruby
#
require 'rubygems' unless defined? Gem # Old rubygems.

# My Application
class Application
  MINIMUM_VERSION = '2.1.11'
  attr_reader :debug
  alias_method :debug?, :debug

  def initialize(argv = ARGV)
    @debug = argv.include?('-d') || argv.include?('--debug')
  end

  def run
    debug "Current version: #{current}"
    debug "Latest version:  #{latest}"

    exit 2 if upgrade_required?
    exit 1 if upgrade_nice?
    exit 0
  end

  def debug(str)
    $stderr.puts "** DEBUG: #{str}" if debug?
  end

  def current
    @current ||= Gem::Version.new(Gem::VERSION)
  end

  def latest
    @latest ||= Gem.latest_rubygems_version
  end

  def minimum
    @minimum ||= Gem::Version.new(MINIMUM_VERSION)
  end

  def upgrade_nice?
    current.bump < latest.bump
  end

  def upgrade_required?
    current.bump < minimum.bump
  end
end

Application.new.run if __FILE__ == $PROGRAM_NAME
