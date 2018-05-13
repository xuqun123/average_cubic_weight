require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  render_views

  describe '#index' do
    it 'should render correctly' do
      get :index
      expect(response).to be_success

      expect(assigns(:products).count).to eq 0
    end    

   it 'should render correctly' do
      Product.create category: "TVs", length: 0.3, width: 0.2, height: 0.5, title: "Samsung TV", weight: 20
      Product.create category: "TVs", length: 0.9, width: 0.1, height: 0.2, title: "AOC TV", weight: 10    
      Product.create category: "Air Conditioners", length: 0.4, width: 0.9, height: 0.2, title: "LG Air Con", weight: 25

      get :index
      expect(response).to be_success

      expect(assigns(:products).count).to eq 3
    end    
  end
end
