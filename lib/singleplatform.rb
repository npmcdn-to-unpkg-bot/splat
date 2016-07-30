require 'base64'
require 'openssl'
require 'cgi'
require 'faraday'
require 'json'

module Singleplatform
  class Client
    HOST = 'http://publishing-api.singleplatform.com'.freeze
    API_KEY = 'khf3fhjsbf1095basvlsgfeut'.freeze
    CLIENT_ID = 'ccasmp9mugzpace7mozujntr4'.freeze
    CLIENT_SECRET = 'RDNlCbEuFUbqUim6Lb3ZAZrsVj_kV-cWoIINMcb4aC0'.freeze

    def initialize
      @client_id = CLIENT_ID
      @client_secret = CLIENT_SECRET
    end

    def locations(id = nil)
      url = generate_url("/locations/#{id}")
      response = initialize_request.get(url)
      response.body.gsub!(/\"/, '\'')
    end

    def menus(location_id); end

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
      path = endpoint + '?client=' + CLIENT_ID
      puts path
      key = OpenSSL::HMAC.digest('sha1', CLIENT_SECRET, path)
      CGI::escape(Base64.encode64(key).chomp)
    end
  end
end