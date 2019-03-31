# frozen_string_literal: true

require 'bundler'

Bundler.require(:default)

require_relative 'config/sources'
require_relative 'lib/command'
require_relative 'lib/fetcher'
require_relative 'lib/paginator'
require_relative 'lib/parser'
require_relative 'lib/pipeline'
require_relative 'lib/writer'

class App
  def initialize(options)
    @options = options
  end

  def run!
    return if options[:check]

    parsed_output = Sources.new(expression: options[:filter]).flat_map do |source|
      Paginator.new(source: source).get_page_list.flat_map do |url|
        html = Fetcher.new(url: url).fetch
        Parser.new(source: source, html: html).parse
      end
    end
    puts "Fetched #{parsed_output.count} entries."
    if options[:write]
      Writer.new(output: parsed_output, path: options[:write]).run
      puts "Written #{parsed_output.count} entries to #{options[:write]}."
    else
      puts parsed_output
    end
  end

  private

  attr_reader :options
end
