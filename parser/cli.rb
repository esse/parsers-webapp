# frozen_string_literal: true

require 'bundler'

require_relative 'fetcher'
require_relative 'parser'
require_relative 'pipeline'
require_relative 'sources'

# TODO: add option parser and help

Sources.new.each do |source|
  html = Fetcher.new(source: source).fetch
  puts Parser.new(source: source, html: html).parse
end
