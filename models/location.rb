class Location
  attr_accessor :name, :address, :city, :state, :zip, :latitude, :longitude,
                :owner_verfied, :spv2

  def initialize(args = {})
    return nil if args.empty?
    @name          = args[:name]
    @address       = args[:address]
    @city          = args[:city]
    @state         = args[:state]
    @zip           = args[:zip]
    @owner_verfied = false
    geocode unless unable_to_geocode?(args)
  end

  def geocode
    coords = GeocoderService.new.geocode("
                                          #{@address},
                                          #{@city},
                                          #{@state},
                                          #{@zip}
                                        ")
    @lat = coords[0]
    @lng = coords[1]
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