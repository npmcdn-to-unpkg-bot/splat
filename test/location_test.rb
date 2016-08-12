ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require 'sinatra/activerecord'
require_relative '../splat'
require_relative '../models/location'

class LocationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  # Validations

  def test_address_is_required
    @lead = Location.new(
      name:      'SinglePlatform',
      address_1: nil,
      city:      'New York',
      region_id: 'NY',
      postcode:  '11102'
    )
    assert !@lead.valid?
  end

  def test_city_is_required
    @lead = Location.new(
      name:      'SinglePlatform',
      address_1: '17 Battery Place',
      city:      nil,
      region_id: 'NY',
      postcode:  '11102'
    )
    assert !@lead.valid?
  end

  def test_region_is_required
    @lead = Location.new(
      name:      'SinglePlatform',
      address_1: '17 Battery Place',
      city:      'New York',
      region_id: nil,
      postcode:  '11102'
    )
    assert !@lead.valid?
  end

  def test_postcode_is_required
    @lead = Location.new(
      name:      'SinglePlatform',
      address_1: '17 Battery Place',
      city:      'New York',
      region_id: 'NY',
      postcode:  nil
    )
    assert !@lead.valid?
  end
end