# frozen_string_literal: true

require 'bundler'

Bundler.require(:default, :development)

require_relative 'config/sources'
require_relative 'lib/fetcher'
require_relative 'lib/pipeline'
require_relative 'lib/parser'
require_relative 'lib/command'
require_relative 'lib/uploader'

class App
  def initialize(options)
    @options = options
  end

  def run
    if options[:check]
      return
    end
    parsed_output = Sources.new(expression: options[:filter]).flat_map do |source|
      html = Fetcher.new(source: source).fetch
      Parser.new(source: source, html: html).parse
    end
    puts "Fetched #{parsed_output.count} entries."
    if options[:write]
      Writer.new(output: parsed_output, path: options[:write]).run
      puts "Written #{parsed_output.count} entries to #{options[:write]}."
    end
    if options[:url]
      Uploader.new(output: parsed_output, url: options[:url]).run
      puts "Uploaded #{parsed_output.count} entries to #{options[:url]}."
    end
  end

  private

  attr_reader :options
end
