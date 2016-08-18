ENV['RACK_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require 'sinatra/activerecord'
require_relative '../splat'
require_relative '../models/location'

class LocationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  # Instance methods

  def test_full_address_concatenates_components
    @lead = Location.new(
      name:      'SinglePlatform',
      address_1: '17 Battery Place',
      city:      'New York',
      region_id: 'NY',
      postcode:  '10004'
    )
    assert @lead.full_address == '17 Battery Place New York NY 10004'
  end

  def test_owner_verified_has_business_id
    @location = Location.new(
      name:               'SinglePlatform',
      address_1:          '17 Battery Place',
      city:               'New York',
      region_id:          'NY',
      postcode:           '11102',
      parent_business_id: 1
    )
    assert @location.owner_verified? == true
  end

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