Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'

  resources :trains
  resources :railway_stations

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
