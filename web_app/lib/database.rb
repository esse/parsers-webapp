class Database
  def initialize
    @json = JSONL.parse(File.read(ENV['DATABASE'])) # TODO: move me to cfg
  end

  def all
    json
  end

  def where
    json.find_all { |record| record }
  end

  private

  attr_reader :json
end
