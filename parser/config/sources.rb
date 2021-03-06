# frozen_string_literal: true

require 'yaml'
require 'forwardable'

class Sources
  extend Forwardable

  def initialize(expression:)
    @parsers = []
    @expression = expression || '*'
    Dir.glob(path) do |rb_file|
      @parsers << YAML.load_file(rb_file)
    end
  end

  def_delegator :@parsers, :flat_map

  private

  attr_reader :expression

  def path
    File.join(__dir__, "sources/#{expression}.yml")
  end
end
