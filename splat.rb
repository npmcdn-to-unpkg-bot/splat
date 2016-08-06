# Load env variables using .env
Dotenv.load

# Models
require './models/location'

# Services & Libraries
require './services/geocoder_service'
require './services/singleplatform_service'
require './lib/singleplatform'

class Splat < Sinatra::Base

  configure do
    enable :logging
  end

  get '/' do
    @l = Location.new(params)
    logger.info 'BUTT'
    puts @name
    erb :index, layout: :main
  end
end