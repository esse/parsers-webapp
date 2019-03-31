module Handlers
  class Index
    def initialize(params:, database:, date_class: Date, adapter: Adapters::Index)
      @params = params
      @dataset = database.dataset
      @adapter = adapter
      @date_class = date_class
    end

    def call
      sanitized_params = adapter.new(params: params).sanitized_params
      if sanitized_params["name"]
        @dataset = @dataset.filter_by_name(sanitized_params["name"])
      end
      if sanitized_params["date"]
        date = date_class.parse(sanitized_params["date"])
        @dataset = @dataset.filter_by_date(date)
      end
      if sanitized_params["source"]
        @dataset = @dataset.filter_by_source(sanitized_params["source"])
      end
      @locals = { dataset: @dataset }
    end

    attr_reader :locals

    private

    attr_reader :params, :date_class, :adapter
  end
end
