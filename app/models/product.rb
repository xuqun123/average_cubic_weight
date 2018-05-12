class Product < ApplicationRecord
  validates :category, :length, :width, :height, presence: true
  validates :title, presence: true, uniqueness: true  

  scope :air_conditioners, -> { where(category: "Air Conditioners") }

  before_save :calculate_volume

  def calculate_volume
  	self.volume = length.to_f * width.to_f * height.to_f
  end
end
