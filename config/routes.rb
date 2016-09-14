Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'

  resources :railway_stations do
    patch :update_position, on: :member
  end
  resources :routes
  resources :trains
  resources :wagons

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
