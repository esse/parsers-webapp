require 'bundler'

require_relative "fetcher"
require_relative "parser"
require_relative "pipeline"
require_relative "sources"

Sources.new.each do |source|
  Fetcher.new(config)
end
