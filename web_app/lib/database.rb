require 'date'
require_relative 'dataset'

class Database
  MUTEX = Mutex.new # synchronise access to @json

  def initialize
    reload!
    @modified_at = file_modification_time
    @sources = @json.map { |record| record['source'] }.uniq.sort
  end

  def file_modification_time
    File.mtime(ENV['DATABASE'])
  end

  def should_reload?
    modified_at != file_modification_time
  end

  def reload_if_needed
    reload! if should_reload?
  end

  def reload!
    MUTEX.synchronize do
      @json = JSONL.parse(File.read(ENV['DATABASE']))
    end
  end

  def dataset
    Dataset.new(json)
  end

  attr_reader :sources

  private

  def json
    MUTEX.synchronize do
      @json
    end
  end

  attr_reader :modified_at, :semaphore
end
