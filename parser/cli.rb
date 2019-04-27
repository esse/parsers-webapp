# frozen_string_literal: true

require_relative 'app'

require 'optionparser'

# TODO: add option parser and help

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'

  opts.on('-f', '--filter expression', 'Filter yamls with bash-like expression') do |f|
    options[:filter] = f
  end

  opts.on('-w', '--write path', 'Write JSONL output into file with provided path') do |w|
    options[:write] = w
  end
end.parse!

App.new(options).run!
