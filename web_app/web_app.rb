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
    erb :index, locals: { database: database.all }
  end

  private

  attr_reader :database
end
