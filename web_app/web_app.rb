# frozen_string_literal: true
Bundler.require(:default)

require 'sinatra/base'
require_relative 'lib/database'

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
    print @dataset
    if params[:name]
      @dataset = @dataset.filter_by_name(params[:name])
    end
    if params[:date]
      date = Date.parse(params[:date])
      @dataset = @dataset.filter_by_date(date)
    end
    if params[:source]
      @dataset = @dataset.filter_by_source(params[:source])
    end
    erb :index
  end

  private

  attr_reader :database
end
