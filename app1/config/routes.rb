Rails.application.routes.draw do
  devise_for :users
  resources :comments
  root to: 'comments#index'
end
