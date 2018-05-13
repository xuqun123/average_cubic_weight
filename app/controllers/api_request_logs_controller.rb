class ApiRequestLogsController < ApplicationController
  def index
  	@api_calculations = ApiCalculation.order('created_at DESC').page(params[:page]).per(4)
  end
end
