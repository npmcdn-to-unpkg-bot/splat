class SingleplatformService
  def initialize
    initialize_external_service
  end

  def locations(id = nil)
    initialize_external_service.locations(id)
  end

  def locations_updated_since
    initialize_external_service.locations_updated_since
  end

  def self.prepare_location_data(response)
    {
      spv2:          response.location_id,
      name:          response.name,
      address:       response.location.address1,
      city:          response.location.city,
      state:         response.location.state,
      zip:           response.location.postal_code,
      latitude:      response.location.latitude,
      longitude:     response.location.longitude,
      owner_verfied: response.is_owner_verified
    }
  end

  private

  def initialize_external_service
    Singleplatform::Client.new
  end
end