Rails.application.routes.draw do
  devise_for :users #, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_scope :user do 
    post '/users', to: 'users/registrations#create', constraints: lambda { |req| req.format == :json }
    post '/users/sign_in', to: 'users/sessions#create', constraints: lambda { |req| req.format == :json }
  end
  resources :comments
  root to: 'comments#index'
end
