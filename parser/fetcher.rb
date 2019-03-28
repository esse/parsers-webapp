require "httparty"

class Fetcher
  def initialize(source:, http_adapter: HTTParty)
    @http_adapter = http_adapter
    @config = config
  end

  def fetch
    http_adapter.get(config["url"])
  end

  private

  attr_reader :http_adapter
end
