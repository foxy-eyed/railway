Rails.application.routes.draw do
  devise_for :users

  root 'searches#show'

  resource :search, only: [:show, :create]

  resources :tickets, only: [:show, :create] do
    collection do
      get :my
      post :buy
    end
  end

  namespace :admin do
    resources :railway_stations do
      patch :update_within_route, on: :member
    end

    resources :routes

    resources :tickets, except: [:new, :create]

    resources :trains do
      resources :wagons, shallow: true
    end
  end
end
