class Paginator
  def initialize(source:, fetcher: Fetcher, pipeline: Pipeline)
    @source = source
    @fetcher = fetcher
    @pipeline = pipeline
  end

  # return list of uris
  def pages_list
    return Array(source['url']) unless source['pagination']

    Pipeline.new(
      instructions: source['pagination'],
      parsed_html: parsed_html
    ).guarded_process
  end

  private

  def parsed_html
    Nokogiri::HTML(fetcher.new(url: source['url']).fetch)
  end

  attr_reader :source, :fetcher, :pipeline
end
