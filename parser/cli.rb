# frozen_string_literal: true

require_relative 'app'

# TODO: add option parser and help

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-d", "--dry", "Dry mode") do |v|
    options[:verbose] = v
  end

  opts.on("-c", "--check", "Check yamls only") do |v|
    options[:verbose] = v
  end

  opts.on("-f", "--filter", "Filter yamls using provided regexp") do |v|
    options[:verbose] = v
  end

  opts.on("-w", "--write", "Write JSON output into file with provided path") do |v|
    options[:verbose] = v
  end

  opts.on("-u", "--upload", "Upload JSON output into provided url") do |v|
    options[:verbose] = v
  end
end.parse!

p options
p ARGV

Sources.new.each do |source|
  html = Fetcher.new(source: source).fetch
  puts Parser.new(source: source, html: html).parse
end
