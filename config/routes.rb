require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'api_calculations#index'
  resources :api_calculations, only: [:create, :index]
  get '/products', to: 'products#index'
  get '/reload', to: 'api_calculations#reload'
  get '/logs', 		 to: 'api_request_logs#index' 

  mount Sidekiq::Web => '/sidekiq'  
end
