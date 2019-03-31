# frozen_string_literal: true

class Fetcher
  def initialize(url:, http_adapter: HTTParty)
    @http_adapter = http_adapter
    @url = url
  end

  def fetch
    http_adapter.get(url)
  end

  private

  attr_reader :url, :http_adapter
end
