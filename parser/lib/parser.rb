# frozen_string_literal: true

class Parser
  def initialize(source:, html:, pipeline: Pipeline, nokogiri_html: Nokogiri::HTML)
    @source = source
    @html = html
    @pipeline = pipeline
    @nokogiri_html = nokogiri_html
  end

  def parse # Todo: there are too many responsibilities here
    list.map do |event|
      source['attributes'].dup.map do |attr_name, attr_cfg|
        [
          attr_name,
          pipeline.new(instructions: attr_cfg, parsed_html: event).process
        ]
      end.to_h
    end
  end

  private

  attr_reader :html, :source, :pipeline, :nokogiri_html

  def parsed_html
    @parsed_html ||= nokogiri_html.parse(html)
  end

  def list
    @list ||= pipeline.new(instructions: source['list'], parsed_html: parsed_html).process
  end

  def xpaths
    source['xpaths']
  end
end
