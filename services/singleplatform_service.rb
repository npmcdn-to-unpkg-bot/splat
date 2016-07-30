class SingleplatformService
  def initialize; end

  private

  def initialize_external_service
    Singleplatform::Client.new()
  end
end