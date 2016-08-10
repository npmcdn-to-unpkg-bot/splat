# Load env variables using .env
require 'dotenv'
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
    @l = Location.find(1)
    puts @name
    erb :index, layout: :main
  end
end