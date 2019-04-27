# frozen_string_literal: true

require_relative 'command'

class Pipeline
  def initialize(instructions:, parsed_html:)
    @instructions = instructions
    @parsed_html = parsed_html
  end

  def guarded_process
    begin
      process
    rescue StandardError
      nil
    end
  end

  def process
    instructions.inject(parsed_html) do |html, instruction|
      Command.new(nodes: html, instruction: instruction).run
    end
  end

  private

  attr_reader :instructions, :parsed_html
end
