require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ApiCalculationsController, type: :controller do
  render_views

  before do
    Sidekiq::Worker.clear_all
  end  

  describe '#index' do
    it 'should render correctly' do
      get :index
      expect(response).to be_success

      expect(assigns(:api_calculation).new_record?).to eq true
    end
  end

  describe '#create' do
    it 'should create an api_calculation entry' do
      post :create, params: {api_calculation: {"endpoint"=>"http://test.com", "conversion_factor"=>"250", "category"=>"Air Conditioners"}}, xhr: true
      expect(response).to be_success

      expect(assigns(:api_calculation).new_record?).to eq false
      expect(assigns(:api_calculation).endpoint).to eq "http://test.com"      
      expect(assigns(:api_calculation).conversion_factor).to eq 250
      expect(assigns(:api_calculation).category).to eq "Air Conditioners"
      
      expect(ApiRequestWorker.jobs.size).to eq 1            
    end  

    it 'should not create if save failure' do
      post :create, params: {api_calculation: {"endpoint"=>"http://test.com"}}, xhr: true
      expect(response).to be_success

      expect(assigns(:api_calculation).new_record?).to eq true

      expect(ApiRequestWorker.jobs.size).to eq 0      
    end      
  end

  describe '#reload' do
    it 'should run correctly' do
      get :reload, xhr: true
      expect(response).to be_success
    end
  end  
end
