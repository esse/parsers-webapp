# frozen_string_literal: true

require 'nokogiri'

class Parser
  def initialize(source:, html:)
    @source = source
    @html = html
  end

  def parse
    list.map do |event|
      source['attributes'].dup.map do |attr_name, attr_cfg|
        [
          attr_name,
          Pipeline.new(instructions: attr_cfg, parsed_html: event).process
        ]
      end.to_h
    end
  end

  private

  attr_reader :html, :source

  def parsed_html
    @parsed_html ||= Nokogiri::HTML.parse(html)
  end

  def list
    @list ||= Pipeline.new(instructions: source['list'], parsed_html: parsed_html).process
  end

  def xpaths
    source['xpaths']
  end
end
