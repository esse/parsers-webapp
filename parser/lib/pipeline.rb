# frozen_string_literal: true

require_relative 'command'

class Pipeline
  def initialize(instructions:, parsed_html:)
    @instructions = instructions
    @parsed_html = parsed_html
  end

  def process
    # https://dry-rb.org/gems/dry-monads/result/
    # TODO: refactor me into a parsing monad
    to_change = parsed_html
    instructions.each do |instruction|
      to_change = Command.new(instruction: instruction, nodes: to_change).run
    end
    to_change
  end

  private

  attr_reader :instructions, :parsed_html
end
