class Paginator
  def initialize(source:, fetcher: Fetcher, pipeline: Pipeline)
    @source = source
    @fetcher = fetcher
    @pipeline = pipeline
  end

  def get_page_list # return list of uris
    return Array(source['url']) unless source['pagination']
    x = Pipeline.new(instructions: source['pagination'], parsed_html: Nokogiri::HTML(fetcher.new(url: source['url']).fetch)).process
    puts x
    exit(0)
  end

  private

  attr_reader :source, :fetcher, :pipeline
end
