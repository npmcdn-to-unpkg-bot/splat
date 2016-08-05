# App
require 'sinatra'
require 'sinatra/reloader' if development?
require 'dotenv'
Dotenv.load

# Models
require './models/location'

# Services & Libraries
require './services/geocoder_service'
require './services/singleplatform_service'
require './lib/singleplatform'

# 3rd Party
require 'geocoder'

get '/' do
  @l = Location.new(params)
  erb :index, layout: :main
end
