class ApiCalculation < ApplicationRecord
  has_many :api_request_logs

  validates :finished, presence: true
  validates :start_time, presence: true, unique: true
end