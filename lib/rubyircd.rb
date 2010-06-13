require 'singleton'
require 'optparse'
require 'yajl'
require 'eventmachine'

require 'rubyircd/version'
require 'rubyircd/server'

class RubyIRCd
  include Singleton

  attr_reader :config

  def initialize
    if ['-v', '--version'].include?(ARGV.first)
      puts "RubyIRCd v#{RubyIRCd::Version}"
      exit 0
    end

    if File.exists?(ARGV.first)
      @config = Yajl::Parser.new(:symbolize_keys => true).parse(File.open(ARGV.first, 'r'))
    else
      puts "Usage: rubyircd CONFIGFILE"
      exit 1
    end
  end

  def run
    EventMachine.run do
      puts "Starting RubyIRCd on #{config[:host]}:#{config[:port]}"
      EventMachine.start_server(config[:host], config[:port], RubyIRCd::Server)
    end
  end
end
