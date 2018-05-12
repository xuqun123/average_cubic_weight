class ApiRequestLog < ApplicationRecord
	belongs_to :api_calculation

  validates :domain, :endpoint, presence: true
end
