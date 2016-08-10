# Load env variables using .env
require 'dotenv'
Dotenv.load

require 'sinatra/activerecord'

# Models
require './models/location'

# Services & Libraries
require 'geocoder'
require './services/geocoder_service'
require './lib/singleplatform'

class Splat < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    enable :logging
  end

  get '/' do
    @lead = Location.new(params)
    @locations = Location.near([@lead.latitude, @lead.longitude], 10)
    puts @name
    erb :index, layout: :main
  end
end