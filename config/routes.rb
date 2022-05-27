Rails.application.routes.draw do
  resources :works
  resources :locations
  
  devise_for :users

  root "locations#index"
end
