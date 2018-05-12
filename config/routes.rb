Rails.application.routes.draw do
  root to: 'api_calculations#index'
  resources :api_calculations, only: [:create, :index]
  get '/products', to: 'products#index'
  get '/logs', 		 to: 'api_request_logs#index'  
end
