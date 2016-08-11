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
    "#{@address_1} #{@city} #{@region_id} #{postcode}"
  end

  def owner_verified?
    self.parent_business_id != nil
  end

  private

  def unable_to_geocode?(args)
    address_missing?(args) || city_missing?(args) || state_missing?(args)
  end

  def address_missing?(args)
    args[:address_1].nil? || args[:address_1].empty?
  end

  def city_missing?(args)
    args[:city].nil? || args[:city].empty?
  end

  def state_missing?(args)
    args[:region_id].nil? || args[:region_id].empty?
  end
end