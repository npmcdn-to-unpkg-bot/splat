# Load env variables using .env
Dotenv.load
require 'sinatra/activerecord'

# Models
require './models/location'

# Services & Libraries
require './services/geocoder_service'
require './lib/singleplatform'

class Splat < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    enable :logging
  end

  get '/' do
    @l = Location.new(params)
    puts @name
    erb :index, layout: :main
  end
end