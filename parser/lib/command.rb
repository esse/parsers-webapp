# frozen_string_literal: true

class Command
  def initialize(instruction:, nodes:)
    @instruction = instruction
    @nodes = nodes
  end

  def run
    step.call(nodes)
  end

  private

  attr_reader :instruction, :nodes

  def step
    case instruction['operand']
    when 'xpath'
      ->(x) { x.xpath(instruction['argument']) }
    when 'inner_html'
      ->(x) { x.inner_html }
    when 'constant'
      ->(_) { instruction['argument'] }
    end
  end
end
