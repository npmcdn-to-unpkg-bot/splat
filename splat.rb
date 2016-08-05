# Load env variables using .env
Dotenv.load

# Models
require './models/location'

# Services & Libraries
require './services/geocoder_service'
require './services/singleplatform_service'
require './lib/singleplatform'

class Splat < Sinatra::Base
  get '/' do
    @l = Location.new(params)
    erb :index, layout: :main
  end
end