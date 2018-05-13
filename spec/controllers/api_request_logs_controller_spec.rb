require 'rails_helper'

RSpec.describe ApiRequestLogsController, type: :controller do
  render_views

  describe '#index' do
    it 'should render correctly' do
      get :index
      expect(response).to be_success

      expect(assigns(:api_calculations).count).to eq 0
    end    

   it 'should render correctly' do
      api_calculation = ApiCalculation.create conversion_factor: 100, endpoint: "http://test1.com", category: "TVs", finished: true
      api_calculation.api_request_logs.create endpoint: "http://test1.com/1"
      api_calculation.api_request_logs.create endpoint: "http://test1.com/2"
      expect(api_calculation.api_request_logs.count).to eq 2

      ApiCalculation.create conversion_factor: 250, endpoint: "http://test2.com", category: "TVs", finished: true 
      ApiCalculation.create conversion_factor: 200, endpoint: "http://test3.com", category: "Air Cons"

      get :index
      expect(response).to be_success


      expect(assigns(:api_calculations).count).to eq 3
    end    
  end
end
