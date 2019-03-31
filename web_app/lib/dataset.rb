require 'forwardable'

class Dataset
  extend Forwardable

  def initialize(array, date: Date)
    @array = array
    @date = date
  end

  def filter_by_name(name)
    filtered_by_name = array.find_all do |record|
      is_similar?(record["name"], name) || is_substring?(record["name"], name)
    end
    Dataset.new(filtered_by_name)
  end

  def filter_by_date(date)
    filtered_by_date = array.find_all do |record|
      date_from = record["date_from"]
      date_to = record["date_to"]
      date_range = date.parse(date_from)..date.parse(date_to)
      date_range.include?(date)
    end
    Dataset.new(filtered_by_date)
  end

  def filter_by_source(source)
    filtered_by_source = array.find_all do |record|
      record["source"] == source
    end
    Dataset.new(filtered_by_source)
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

  attr_reader :array, :date
end
