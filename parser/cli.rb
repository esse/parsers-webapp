# frozen_string_literal: true

require 'bundler'

require_relative 'config/sources'
require_relative 'lib/fetcher'
require_relative 'lib/pipeline'
require_relative 'lib/parser'
require_relative 'lib/command'
require_relative 'lib/uploader'


# TODO: add option parser and help

Sources.new.each do |source|
  html = Fetcher.new(source: source).fetch
  puts Parser.new(source: source, html: html).parse
end
