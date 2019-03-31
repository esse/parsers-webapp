module Adapters
  class Index
    def initialize(params:)
      @params = params
    end

    def sanitized_params
      params.slice(:name, :date, :source).reject { |_, v| v.empty? }
    end

    private

    attr_reader :params
  end
end
