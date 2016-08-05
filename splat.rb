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
  @s = SingleplatformService.new.locations_updated_since('2016-01-01')
  # @s = SingleplatformService.new.locations('nobu')
  erb :index, layout: :main
end
