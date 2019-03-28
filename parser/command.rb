# frozen_string_literal: true

class Command
  def initialize(command:, object:)
    @command = command
    @object = object
  end

  def run
    step.call(object)
  end

  private

  attr_reader :command, :object

  def step
    case command['command']
    when 'xpath'
      ->(x) { x.xpath(command['argument']) }
    when 'inner_html'
      ->(x) { x.inner_html }
    end
  end
end
