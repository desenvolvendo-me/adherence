Rails.application.routes.draw do
  resources :machines
  root 'machines#index'
end