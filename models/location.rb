# Geocoder is loaded in via Railties, so without Rails, it won't load.
require 'geocoder/railtie'
Geocoder::Railtie.insert

class Location < ActiveRecord::Base
  validates_presence_of :address_1, :city, :region_id, :postcode
  # SPDJ has a "type" column; this makes ActiveRecord believe
  # we're trying to use single table inheritance, but we're not,
  # so overwrite it.
  self.inheritance_column = nil

  extend ::Geocoder::Model::ActiveRecord
  geocoded_by :full_address

  def geocode
    coords = GeocoderService.new.geocode(full_address)
    self.latitude = coords[0]
    self.longitude = coords[1]
  end

  def full_address
    "#{address_1} #{city} #{region_id} #{postcode}"
  end

  def owner_verified?
    self.parent_business_id != nil
  end
end