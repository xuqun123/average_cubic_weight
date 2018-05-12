class Product < ApplicationRecord
  validates :category, :length, :width, :height, presence: true

  scope :air_conditioners, -> { where(category: "Air Conditioners") }
end
