# Load env variables using .env
require 'dotenv'
Dotenv.load

require 'sinatra/activerecord'

# Models
require_relative 'models/location'

# Services & Libraries
require 'geocoder'
require_relative 'services/geocoder_service'
require_relative 'lib/singleplatform'
require_relative 'config/geocoder'

class Splat < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  # CONFIG
  configure do
    enable :logging
  end

  # ROUTES
  get '/' do
    @lead = Location.new(
      name:      params[:name],
      address_1: params[:address_1],
      city:      params[:city],
      region_id: params[:region_id],
      postcode:  params[:postcode]
    )
    if @lead.valid?
      @lead.geocode 
      @locations = Location.near([@lead.latitude, @lead.longitude], 10).order(parent_business_id: :asc).limit(50)
      erb :index, layout: :main
    else
      logger.info 'Lead invalid'
      erb :error, layout: :main
    end    
  end

  # HELPERS
  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

end