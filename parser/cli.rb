require 'bundler'

require_relative "fetcher"
require_relative "parser"
require_relative "pipeline"
require_relative "sources"

Sources.new.each do |source|
  html = Fetcher.new(source: source).fetch
  puts Parser.new(source: source, html: html).parse
end
