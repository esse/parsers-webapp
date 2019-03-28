require_relative "command"

class Pipeline
  def initialize(commands:, parsed_html:)
    @commands = commands
    @parsed_html = parsed_html
  end

  def process
    to_change = parsed_html
    commands.each do |command|
      to_change = Command.new(command: command, object: to_change).run
    end
    to_change
  end

  private

  attr_reader :commands, :parsed_html
end
