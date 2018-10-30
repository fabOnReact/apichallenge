Rails.application.routes.draw do
  devise_for :users, skip: ['sessions', 'registrations'] #, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_scope :user do 
    post '/users', to: 'users/registrations#create'
    post '/users/sign_in', to: 'users/sessions#create', as: 'user_session'
    get '/users/sign_in', to: 'devise/sessions#new', as: 'new_user_session'
    delete '/users/sign_out', to: 'devise/sessions#destroy', as: 'destroy_user_session'
    get '/users/cancel', to: 'devise/registrations#cancel', as: 'cancel_user_registation'
    get '/users/sign_up', to: 'devise/registrations#new', as: 'new_user_registration'
    patch '/users', to: 'devise/registration#update', as: 'user_registration'
    put '/users', to: 'devise/registration#update'
    delete '/users', to: 'devise/registration#destroy'
    post '/users', to: 'devise/registration#create'
  end
  resources :comments
  root to: 'comments#index'
end
