# frozen_string_literal: true

require 'nokogiri'

class Parser
  def initialize(source:, html:)
    @source = source
    @html = html
  end

  def parse
    list.map do |event|
      {
        name: Pipeline.new(commands: source['name'], parsed_html: event).process,
        description: '',
        date_from: '',
        date_to: '',
        hour_from: '',
        hour_to: ''
      }
    end
  end

  private

  attr_reader :html, :source

  def parsed_html
    @parsed_html ||= Nokogiri::HTML.parse(html)
  end

  def list
    @list ||= Pipeline.new(commands: source['list'], parsed_html: parsed_html).process
  end

  def xpaths
    source['xpaths']
  end
end
