class ApiCalculationsController < ApplicationController
  def index
  	@api_calculation = ApiCalculation.new
  end

  def create
    @api_calculation  = ApiCalculation.new api_calculation_params
    @api_calculation.finished = false

    @api_calculation.compute if @api_calculation.save
  end

  private

  def api_calculation_params
    params.require(:api_calculation).permit(:endpoint, :conversion_factor, :category)
  end  
end
