ENV['RACK_ENV'] = 'test'

require_relative '../splat'
require 'test/unit'
require 'rack/test'
require 'cgi'

class SplatTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Splat
  end

  def test_it_loads_a_map
    get(
        '/',
        { 
          name:      'test',
          address_1: CGI.escape('17 Battery Place'),
          city:      CGI.escape('New York'),
          region_id: CGI.escape('NY'),
          postcode:  CGI.escape('10004')
        })
    assert last_response.ok?
    assert last_response.body.include?('splat')
  end

  def test_it_errors_when_missing_params
    get('/')
    assert last_response.ok?
    assert last_response.body.include?('Jimmy')
  end
end