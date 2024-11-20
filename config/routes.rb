Rails.application.routes.draw do
  resources :machines
  resources :products
  root 'products#index'
end