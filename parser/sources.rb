require "yaml"
require "forwardable"

class Sources
  extend Forwardable

  def initialize
    @parsers = []
    Dir.glob(path) do |rb_file|
      @parsers << YAML.load_file(rb_file)
    end
  end

  def_delegator :@parsers, :each

  private

  def path
    File.join(File.expand_path(File.dirname(__FILE__)), "sources/*.yml")
  end
end
