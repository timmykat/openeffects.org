Ofx::Application.routes.draw do

  resources :links
  
#  resources :home_heros
  post 'admin/home_heroes', to: 'home_heroes#create_and_update'

  resources :standard_changes
  resources :comments, :except => [:index]
  
  resources :versions, except: [:index]
  
  # Add Devise for user authorization, create the other user routes normally
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  resources :users, except: [:new, :create]
  
  #AJAX
  scope :ajax do
    get 'users/toggle',               to: 'users#toggle'
    get 'api_docs/start_stream',      to: 'api_docs#start_stream'
    get 'api_docs/update',            to: 'api_docs#update'
    get 'api_docs/insert_nav',        to: 'api_docs#insert_nav'
    get 'api_docs/test',              to: 'api_docs#test'
  end
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'welcome#index'
  

  resources :companies
  resources :contents
  get 'contents/page/:ident', to: "contents#page_display"
  
  resources :minutes
  get '/minutes/ajax/toggle_published', to: 'minutes#toggle_published'
  
  resources :news_items
  
  # Contact form 
  get   '/contact_form',        to: "contact_form#display"
  post  '/contact_form',        to: "contact_form#send_form_mail"
  
  # Administrative dashboard
  get 'admin/dashboard', to: 'admin#dashboard'
end
