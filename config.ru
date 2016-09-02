require 'rubygems'
require 'bundler'

Bundler.require

# Load env variables using .env
Dotenv.load

require './splat'
run Splat