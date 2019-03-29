# frozen_string_literal: true

class Writer
  def initialize(output:, path:)
    @output = output
    @path = path
  end

  def run
    generated_json = JSONL.generate(output)
    File.open(path, 'w') { |f| f.puts(generated_json) }
  end

  private

  attr_reader :output, :path
end
