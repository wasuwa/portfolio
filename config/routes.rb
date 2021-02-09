Rails.application.routes.draw do

  # static_pages
  root 'static_pages#home'
  get '/email', to: 'static_pages#email'
  
  # users
  resources :users, only: [:show, :create, :edit, :update]
  get '/signup', to: 'users#new'
  
  # sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # password_resets
  resources :password_resets, only: [:create, :edit, :update]
  get '/password_resets', to: 'password_resets#new'
  
  # articles
  resources :articles do
    # favorites
    resources :favorites, only: [:create, :destroy]
    # comments
    resources :comments, only: [:create, :destroy]
  end
  get '/favorites', to: 'favorites#index'
end