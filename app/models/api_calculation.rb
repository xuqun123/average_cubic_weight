class ApiCalculation < ApplicationRecord
  has_many :api_request_logs

  validates :endpoint, :conversion_factor, presence: true
	validates :endpoint, :format => { :with => URI::regexp(%w(http https)), :message => "is invalid"}

  def self.all_finished?
  	where(finished: false).count == 0
  end

  #calculate average cubic weight of a given category with API endpoint and conversion factor
  def compute
  	self.start_time = DateTime.now

    #call API request methods to fetch products
		ApiRequestLog.process(self, endpoint)

		products = if category.present?
			Product.where(category: category)
		else
			Product.all
		end

    #compute average cubic weight
		if products.count > 0
			_total_cubic_weight = products.inject(0) {|r, p| r += p.volume.to_f * conversion_factor} 
			self.average_cubic_weight = _total_cubic_weight.to_f / products.count 
		end

    #update tracking data
		self.finished = true
		self.end_time = DateTime.now
		self.duration = end_time - start_time
		self.save(validate: false)

    #broadcast to client side to notify with calcualted average cubic weight of a related category
    if category.present?
      ActionCable.server.broadcast "api_request_notifications_channel", weight: "#{average_cubic_weight} kg", category: category
    else
      ActionCable.server.broadcast "api_request_notifications_channel", weight: "#{average_cubic_weight} kg"
    end
	rescue
  end
end