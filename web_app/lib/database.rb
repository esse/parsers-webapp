class Database
  def initialize
    @json = JSONL.parse(File.read(ENV['DATABASE'])) # TODO: move me to cfg
  end

  def all
    json
  end

  def where(*)
    json.find_all { |record| record }
  end

  def filter_by_name(name)
    json.find_all { |record| is_similar?(record["name"], name) || is_substring?(record["name"], name) }
  end

  def sources
    @sources ||= json.map { |record| record["source"] }.uniq
  end

  private

  def is_similar?(a, b)
    Levenshtein.normalized_distance(a.downcase,b.downcase) < 0.3 # chosen quasi-randomly ;)
  end

  def is_substring?(a, b)
    a.downcase.include?(b.downcase) || b.downcase.include?(a.downcase)
  end

  attr_reader :json
end
