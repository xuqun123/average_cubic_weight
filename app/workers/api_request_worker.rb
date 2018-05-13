class ApiRequestWorker
  include Sidekiq::Worker

  def perform(api_calculation_id)
    api_calculation = ApiCalculation.find_by id: api_calculation_id
    api_calculation.compute if api_calculation
  end
end
