Rails.application.routes.draw do

  # static_pages
  get 'users/new'
  root 'static_pages#home'
  get '/profile/article_details', to: 'static_pages#article_details'
  get '/profile/my_article_details', to: 'static_pages#my_article_details'
  get '/profile/article_posting', to: 'static_pages#article_posting'
  get '/other_profile', to: 'static_pages#other_profile'
  get '/new_articles', to: 'static_pages#new_articles_list'
  get '/favorite', to: 'static_pages#favorite_list'
  
  # users
  resources :users

  # sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # password_resets
  resources :password_resets, only: [:new, :create, :edit, :update]
  get '/password_resets', to: 'password_resets#new'
  post '/password_resets', to: 'password_resets#create'
  # get '/password_resets/トークン/edit', to: 'password_resets#edit'
  # get '/password_resets/トークン/', to: 'password_resets#update'
end