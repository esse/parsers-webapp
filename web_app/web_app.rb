require "sinatra/base"

class WebApp < Sinatra::Base
  get '/' do
    File.read("/app/data/database.jsonl")
  end
end
