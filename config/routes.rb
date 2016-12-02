
Rails.application.routes.draw do
  
  #get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'static_pages#home'

  #get 'static_pages/home'
  get  '/home', to: 'static_pages#home'
  #get 'static_pages/about'
  get '/about', to: 'static_pages#about'
  
  resources :users
  resources :account_activations, only: [:edit]
  
end
