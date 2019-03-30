# frozen_string_literal: true
Bundler.require(:default)

require 'sinatra/base'
require_relative 'lib/database'

class WebApp < Sinatra::Base
  def initialize
    @database = Database.new
    super
  end

  get '/' do
    if params[:name]
      events = database.filter_by_name(params[:name])
    else
      events = database.all
    end
    erb :index, locals: { events: events }
  end

  private

  attr_reader :database
end
