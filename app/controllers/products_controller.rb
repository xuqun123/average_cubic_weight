class ProductsController < ApplicationController
  def index
  	@products = Product.order("category asc")
  end
end
