class Location
  attr_accessor :name, :address, :city, :state, :zip, :latitude, :longitude,
                :owner_verfied, :spv2

  def initialize(args = {})
    @name          = args[:name]
    @address       = args[:address]
    @city          = args[:city]
    @state         = args[:state]
    @zip           = args[:zip]
    @owner_verfied = false
    geocode
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
end