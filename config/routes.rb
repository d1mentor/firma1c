Rails.application.routes.draw do
  resources :customers
  resources :workers
  resources :diaries
  resources :works
  resources :locations
  
  devise_for :users

  root "locations#index"
end
