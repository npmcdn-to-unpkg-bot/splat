class Location < ActiveRecord::Base
  attr_accessor :name, :address, :city, :state, :zip, :latitude, :longitude,
                :spv2

  # SPDJ has a "type" column; this makes ActiveRecord believe
  # we're trying to use single table inheritance, but we're not,
  # so overwrite it.
  self.inheritance_column = nil

  def initialize(args = {})
    return nil if args.empty?
    @name    = args[:name]
    @address = args[:address]
    @city    = args[:city]
    @state   = args[:state]
    @zip     = args[:zip]
    geocode unless unable_to_geocode?(args)
    logger.info 'Cannot geocode' if unable_to_geocode?(args)
  end

  def geocode
    coords = GeocoderService.new.geocode("
                                          #{@address},
                                          #{@city},
                                          #{@state},
                                          #{@zip}
                                        ")
    @latitude = coords[0]
    @longitude = coords[1]
  end

  private

  def unable_to_geocode?(args)
    address_missing?(args) || city_missing?(args) || state_missing?(args)
  end

  def address_missing?(args)
    args[:address].nil? || args[:address].empty?
  end

  def city_missing?(args)
    args[:city].nil? || args[:city].empty?
  end

  def state_missing?(args)
    args[:state].nil? || args[:state].empty?
  end
end