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
    @lead = Location.new(
      name:      params[:name],
      address_1: params[:address_1],
      city:      params[:city],
      region_id: params[:region_id],
      postcode:  params[:postcode]
    )
    @lead.geocode
    @locations = Location.near([@lead.latitude, @lead.longitude], 5).limit(20)
    erb :index, layout: :main
  end
end