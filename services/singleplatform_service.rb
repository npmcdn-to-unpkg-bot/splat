class SingleplatformService
  def initialize
    initialize_external_service
  end

  def locations(id = nil)
    initialize_external_service.locations(id)
  end

  def locations_updated_since(date)
    initialize_external_service.locations_updated_since(date)
  end

  private

  def initialize_external_service
    Singleplatform::Client.new
  end
end