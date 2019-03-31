# frozen_string_literal: true
Bundler.require(:default)

require 'sinatra/base'
require_relative 'lib/database'
require_relative 'adapters/index'

require_relative 'handlers/index'

require 'date'

class WebApp < Sinatra::Base
  def initialize
    @database = Database.new
    super
  end

  before do
    @sources = database.sources
  end

  after do
    database.reload_if_needed
  end

  get '/' do
    @dataset = database.dataset
    sanitized_params = Adapters::Index.new(params: params).sanitized_params
    puts sanitized_params
    if sanitized_params["name"]
      @dataset = @dataset.filter_by_name(sanitized_params["name"])
    end
    if sanitized_params["date"]
      date = Date.parse(sanitized_params["date"])
      @dataset = @dataset.filter_by_date(date)
    end
    if sanitized_params["source"]
      @dataset = @dataset.filter_by_source(sanitized_params["source"])
    end
    erb :index
  end

  private

  attr_reader :database
end
