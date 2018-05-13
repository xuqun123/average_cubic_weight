class ApiCalculationsController < ApplicationController
  def index
  	@api_calculation = ApiCalculation.new
  end

  def create
    @api_calculation  = ApiCalculation.new api_calculation_params
    @api_calculation.finished = false

    ApiRequestWorker.perform_async(@api_calculation.id) if @api_calculation.save
  end

  def reload
  end

  private

  def api_calculation_params
    params.require(:api_calculation).permit(:endpoint, :conversion_factor, :category)
  end  
end
