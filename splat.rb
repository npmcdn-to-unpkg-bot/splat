# App
require 'sinatra'
require 'sinatra/reloader' if development?

# Models
require './models/location'

# Services & Libraries
require './services/geocoder_service'
require './services/singleplatform_service'
require './lib/singleplatform'

# 3rd Party
require 'geocoder'

get '/' do
  s = SingleplatformService.new.location('nobu')
  @sp = SingleplatformService.prepare_location_data(s)
  erb :index, layout: :main
end
