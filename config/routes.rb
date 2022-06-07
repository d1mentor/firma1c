Rails.application.routes.draw do
  resources :materials
  resources :suppliers
  resources :supplies
  resources :instruments
  resources :transports
  resources :payments
  resources :customers
  resources :workers
  resources :diaries
  resources :works
  resources :locations
  
  devise_for :users

  root "locations#index"
end
