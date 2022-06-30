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
  resources :galleries

  get '/load_img', to: 'galleries#load_img'
  get '/set_img_to_destroy', to: 'galleries#set_img_to_destroy'
  post '/add_img', to: 'galleries#add_img'
  post '/destroy_img', to: 'galleries#destroy_img'

  get 'choose_source_for_new_payment', to: 'payments#choose'
  get '/customers_list_for_payments', to: 'customers#list_for_payments'
  get '/transports_list_for_payments', to: 'transports#list_for_payments'
  get '/instruments_list_for_payments', to: 'instruments#list_for_payments'
  get '/workers_list_for_payments', to: 'workers#list_for_payments'
  get '/works_list_for_payments', to: 'works#list_for_payments'
  get '/supplies_list_for_payments', to: 'supplies#list_for_payments'
  get '/capital', to: 'payments#capital'

  devise_for :users

  root "locations#index"
end
