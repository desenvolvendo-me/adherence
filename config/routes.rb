Rails.application.routes.draw do
  resources :machines
  resources :products
  root 'home#index'
end