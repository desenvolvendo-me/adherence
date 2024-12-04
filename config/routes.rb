Rails.application.routes.draw do
  resources :production_plannings
  resources :machines do
    get 'products', on: :member
  end
  resources :products
  root 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check
end