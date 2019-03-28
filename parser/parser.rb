require "nokogiri"

class Parser
  def initialize(source:, html:)
    @source = source
    @html = html
  end

  def parse
    parsed_html.xpath(xpaths["list"]).map do |event|
      {
        name: event.xpath(xpaths["name"]).inner_html
      }
    end
  end

  private

  attr_reader :html, :source

  def parsed_html
    @parsed_html ||= Nokogiri::HTML.parse(html)
  end

  def xpaths
    source["xpaths"]
  end
end
