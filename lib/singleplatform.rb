require 'base64'
require 'openssl'
require 'cgi'
require 'faraday'
require 'json'
require 'hashie'

module Singleplatform
  class Client
    HOST = ENV['HOST'].freeze
    API_KEY = ENV['API_KEY'].freeze
    CLIENT_ID = ENV['CLIENT_ID'].freeze
    CLIENT_SECRET = ENV['CLIENT_SECRET'].freeze

    def initialize
      @client_id = CLIENT_ID
      @client_secret = CLIENT_SECRET
    end

    def locations(id = nil)
      tries ||= 3
      url = generate_url("/locations/#{id}")
      response = initialize_request.get(url)
    rescue
      sleep 5
      retry if (tries > 0)
      return false
    else
      Hashie::Mash.new(JSON.parse(response.body)).data
    end

    private

    def initialize_request
      Faraday.new(url: HOST) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end

    def generate_url(endpoint)
      "#{HOST}#{endpoint}?client=#{CLIENT_ID}&signature=#{generate_signature(endpoint)}"
    end

    def generate_signature(endpoint)
      path = "#{endpoint}?client=#{CLIENT_ID}"
      key = OpenSSL::HMAC.digest('sha1', CLIENT_SECRET, path)
      CGI::escape(Base64.encode64(key).chomp)
    end
  end
end