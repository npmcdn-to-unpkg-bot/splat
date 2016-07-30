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
  @lead = Location.new(
    name:     'My Place',
    address:  '30-60 29th Street',
    city:     'Astoria',
    state:    'New York',
    zip:      '11102'
  )
  s = Singleplatform::Client.new
  @sp = s.locations('nobu')
  erb :index, layout: :main
end
