# frozen_string_literal: true

require_relative 'command'

class Pipeline
  def initialize(instructions:, parsed_html:)
    @instructions = instructions
    @parsed_html = parsed_html
  end

  def process
    # TODO: refactor me
    to_change = parsed_html
    instructions.each do |instruction|
      to_change = Command.new(instruction: instruction, nodes: to_change).run
    end
    to_change
  end

  private

  attr_reader :instructions, :parsed_html
end
