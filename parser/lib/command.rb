# frozen_string_literal: true

require 'date'

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

  # TODO: extract separate commands classes
  def step
    case instruction['operand']
    when 'xpath'
      ->(x) { x.xpath(instruction['argument']) }
    when 'inner_html'
      ->(x) { x.inner_html }
    when 'constant'
      ->(_) { instruction['argument'] }
    when 'first_match_group_from_regexp'
      ->(x) { x.match(Regexp.new(instruction['argument']))[1] }
    when 'attr'
      ->(x) { x.attr(instruction['argument']) }
    when 'parse_as_date'
      ->(x) { Date.parse(x) }
    when 'or'
      lambda { |x|
        instruction['argument'].flat_map do |instructions|
          Pipeline.new(instructions: instructions, parsed_html: x).guarded_process
        end
                               .find { |node| !node.nil? && !node.blank? }
      }
    when 'uniq'
      ->(x) { x.uniq }
    when 'extract_href'
      ->(x) { x.map { |node| node.attr('href') } }
    when 'compact'
      ->(x) { x.reject(&:empty?) }
    when 'concat'
      lambda { |x|
        instruction['argument'].flat_map do |instructions|
          Pipeline.new(instructions: instructions, parsed_html: x).guarded_process
        end
      }
    when 'prepend_string'
      ->(x) { x.map { |s| instruction['argument'] + s } }
    when 'prepend_single_string'
      ->(x) { instruction['argument'] + x }
    when 'puts'
      lambda { |x|
        puts x
        x
      }
    when 'first'
      ->(x) { x.first }
    end
  end
end
