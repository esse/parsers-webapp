# frozen_string_literal: true

class Writer
  def initialize(output:, path:, jsonl: JSONL, file: File)
    @output = output
    @path = path
    @jsonl = jsonl
    @file = file
  end

  def run
    generated_json = jsonl.generate(output)
    file.open(path, 'w') { |f| f.puts(generated_json) }
  end

  private

  attr_reader :output, :path, :jsonl, :file
end
