Rails.application.routes.draw do
  devise_for :users
  
  root 'welcome#index'

  get 'welcome/index'

  resource :search, only: [:show, :create]

  resources :railway_stations do
    patch :update_within_route, on: :member
  end

  resources :routes

  resources :tickets, only: [:show, :create] do
    post :buy, on: :collection
  end

  resources :trains do
    resources :wagons, shallow: true
  end
end
