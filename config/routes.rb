Rails.application.routes.draw do
  resources :machines
  resources :products
  root 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check
end