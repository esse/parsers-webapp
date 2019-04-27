module Handlers
  class Index
    def initialize(params:, database:, date_class: Date, adapter: Adapters::Index)
      @params = params
      @dataset = database.dataset
      @adapter = adapter
      @date_class = date_class
    end

    def call
      filter_dataset_by_name
      filter_dataset_by_date
      filter_dataset_by_source
      @locals = { dataset: @dataset }
    end

    attr_reader :locals

    private

    attr_reader :params, :date_class, :adapter

    def sanitized_params
      @sanitized_params ||= adapter.new(params: params).sanitized_params
    end

    def name
      @name ||= sanitized_params['name']
    end

    def source
      @source ||= sanitized_params['source']
    end

    def date
      @date ||= sanitized_params['date']
    end

    def filter_dataset_by_name
      @dataset = @dataset.filter_by_name(name) if name
    end

    def filter_dataset_by_date
      if Validators::Date.valid?(date) # rubocop:disable Style/GuardClause
        # rubocop:disable Style/AsciiComments
        # not sure why rubocop wants to put guard clause here ¯\_(ツ)_/¯
        # rubocop:enable  Style/AsciiComments
        parsed_date = date_class.parse(date)
        @dataset = @dataset.filter_by_date(parsed_date)
      end
    end

    def filter_dataset_by_source
      @dataset = @dataset.filter_by_source(source) if source
    end
  end
end
