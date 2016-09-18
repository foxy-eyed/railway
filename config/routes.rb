Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'

  resource :search, only: [:show]

  resources :railway_stations do
    patch :update_position, on: :member
  end
  resources :routes
  resources :trains do
    resources :wagons, shallow: true
  end
end
