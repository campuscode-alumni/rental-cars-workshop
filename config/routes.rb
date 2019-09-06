Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_models, only: %i[show new create]
  resources :subsidiaries, only: %i[show new create]
  resources :rentals, only: %i[show new create] do
    member do
      get 'new_car_return'
      post 'return_car'
    end
  end
  resources :subsidiary_car_models, only: %i[show new create]
  resources :cars, only: %i[show new create] do
    resources :fines, only: %i[show new create]
    resources :maintenances, only: %i[show new create edit update]
    resources :fines, only: %i[show new create]
    resources :inspections, only: %i[ new create]
  end

  resources :maintenances, only: %i[index] do
    member do
      get 'new_return'
      post 'car_return'
    end
  end
 resources :customers, only: %i[index show new create edit update]

 namespace :api do
  namespace :v1 do
    resources :cars, only: %i[show]
    resources :subsidiaries, only: %i[index]
      resources :manufactures, only: %i[create]
    end
  end
end
