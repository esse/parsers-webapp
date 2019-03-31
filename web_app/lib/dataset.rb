require 'forwardable'

class Dataset
  extend Forwardable

  def initialize(array)
    @array = array
  end

  def filter_by_name(name)
    Dataset.new(array.find_all { |record| is_similar?(record["name"], name) || is_substring?(record["name"], name) })
  end

  def filter_by_date(date)
    Dataset.new(find_all { |record| (Date.parse(record["date_from"])..Date.parse(record["date_to"])).include?(date) })
  end

  def filter_by_source(source)
    Dataset.new(array.find_all { |record| record["source"] == source })
  end

  def_delegator :@array, :each

  private


  # TODO: move me to similarity scoring

  def is_similar?(a, b)
    Levenshtein.normalized_distance(a.downcase,b.downcase) < 0.3 # chosen quasi-randomly ;)
  end

  def is_substring?(a, b)
    a.downcase.include?(b.downcase) || b.downcase.include?(a.downcase)
  end

  attr_reader :array
end
