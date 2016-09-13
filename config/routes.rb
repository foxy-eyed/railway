Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'

  resources :railway_stations
  resources :routes do
    patch :update_station_position, on: :member
  end
  resources :trains
  resources :wagons

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
