class ApiRequestLogsController < ApplicationController
  def index
  	@api_request_logs = ApiRequestLog.all
  end
end
