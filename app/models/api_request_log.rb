require 'net/http'

class ApiRequestLog < ApplicationRecord
	belongs_to :api_calculation

  validates :endpoint, :api_calculation_id, presence: true

  def self.process(api_calculation, http_request)
    api_request_log = self.create api_calculation: api_calculation, endpoint: http_request, requested_time: DateTime.now

    begin
      result = self.send_request(http_request)
      api_request_log.update_column :response, result.to_s if api_request_log

      if result["objects"].present?

        result["objects"].each do |object|
          if object["size"]["length"] && object["size"]["width"] && object["size"]["height"]
            product = Product.create category: object["category"], length: object["size"]["length"].to_f/100, 
                           width: object["size"]["width"].to_f/100, height: object["size"]["height"].to_f/100, 
                           title: object["title"], weight: object["weight"].to_f/1000
          end
        end

        if result["next"].present? 
          self.process(api_calculation, http_request.gsub(/\/api\/.*\Z/,"") + result["next"])
        end
      end      
    rescue Exception => e
      api_request_log.update_column(:request_errors, e.to_s) if api_request_log
    end
  end

  def self.send_request(http_request)
    uri = URI.parse(http_request)
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE    
    http.open_timeout = 60
    http.read_timeout = 60    

    request = Net::HTTP::Get.new(uri.request_uri)
    request['Accept'] = "application/json"
    request['Content-Type'] = "application/json"
    response = http.request(request)
    JSON.parse(response.body)
  end
end
