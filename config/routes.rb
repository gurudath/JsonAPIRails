MainApp::Application.routes.draw do
  namespace :api, default: {format: 'json'} do
    namespace :v1 do
      resources :short_visits, only: [:index]
      resources :short_urls, only: [:index,:new,:create,:destroy]
      match '/new_short_url' => 'short_urls#create', via: :post, as: :new_user
      match 'delete_short_url/:id' => 'short_urls#destroy', via: :get, as: :delete_short_url
    end
  end
  match 'short/:token' => 'api/v1/short_urls#redirect_short', via: :get
  match 'generate_token'=>'application#generate_token', via: :get
  root 'api/v1/login#index'
end
