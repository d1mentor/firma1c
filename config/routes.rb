Rails.application.routes.draw do
  get 'errors/not_found'
  get 'sitemap/sitemap'
  resources :notices
  
  get '/index', to:'cutaway#index'
  get '/about_us', to: 'cutaway#about_us'
  get '/services', to: 'cutaway#services'
  get '/portfolio', to: 'cutaway#portfolio'
  get '/contacts', to: 'cutaway#contacts'
  post "/contacts_form_send", to: "cutaway#contacts_form_send"
  get '/sitemap', to: 'sitemap#sitemap', defaults: { format: 'xml' }
  get '404', :to => 'errors#not_found'

  devise_for :users


devise_scope :user do
  unauthenticated :user do
    root 'cutaway#index', as: :unauthenticated_root
  end

  authenticated :user do
    root "locations#dashboard", as: :authenticated_root

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
    resources :payment_tags

    get '/portfolio_gallery', to: 'cutaway#gallery'

    get '/load_img', to: 'galleries#load_img'
    get '/set_img_to_destroy', to: 'galleries#set_img_to_destroy'
    post '/add_img', to: 'galleries#add_img'
    post '/destroy_img', to: 'galleries#destroy_img' 

    get '/choose_source_for_new_payment', to: 'payments#choose'
    get '/customers_list_for_payments', to: 'customers#list_for_payments'
    get '/transports_list_for_payments', to: 'transports#list_for_payments'
    get '/instruments_list_for_payments', to: 'instruments#list_for_payments'
    get '/workers_list_for_payments', to: 'workers#list_for_payments'
    get '/works_list_for_payments', to: 'works#list_for_payments'
    get '/supplies_list_for_payments', to: 'supplies#list_for_payments'
    get '/capital', to: 'payments#capital'
    get '/logs', to: 'logs#index'
  end
  end
end
