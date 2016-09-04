Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'

  resources :railway_stations
  resources :routes
  resources :trains

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
