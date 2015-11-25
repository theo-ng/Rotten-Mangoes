Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  match "/switch_account/:id" => 'admin/users#switch_account', via: 'GET'

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'
end
