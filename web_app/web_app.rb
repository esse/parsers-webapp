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
    handler = Handlers::Index.new(params: params, database: database)
    handler.call
    erb :index, locals: handler.locals
  end

  private

  attr_reader :database
end
