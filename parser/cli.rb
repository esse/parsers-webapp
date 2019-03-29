# frozen_string_literal: true

require_relative 'app'

require 'optionparser'

# TODO: add option parser and help

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'

  opts.on('-c', '--check', 'Check yamls only') do |c|
    options[:check] = c
  end

  opts.on('-f', '--filter regexp', 'Filter yamls with provided regexp') do |r|
    options[:regexp] = r
  end

  opts.on('-w', '--write path', 'Write JSON output into file with provided path') do |w|
    options[:write] = w
  end

  opts.on('-u', '--upload url', 'Upload JSON output into provided url') do |u|
    options[:upload] = u
  end
end.parse!

p options
p ARGV

# Sources.new.each do |source|
#   html = Fetcher.new(source: source).fetch
#   puts Parser.new(source: source, html: html).parse
# end
