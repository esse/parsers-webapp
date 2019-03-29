# frozen_string_literal: true

class Fetcher
  def initialize(source:, http_adapter: HTTParty)
    @http_adapter = http_adapter
    @source = source
  end

  def fetch
    http_adapter.get(source['url'])
  end

  private

  attr_reader :http_adapter, :source
end
