# Service to geocode addresses using geocoder rubygem
class GeocoderService
  def geocode(address)
    external_geocode(address)
  end

  private

  def external_geocode(address)
    Geocoder.coordinates(address)
  end
end