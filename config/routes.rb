Rails.application.routes.draw do

  # static_pages
  root 'static_pages#home'
  get '/profile/article_details', to: 'static_pages#article_details'
  get '/profile/my_article_details', to: 'static_pages#my_article_details'
  get '/new_articles', to: 'static_pages#new_articles_list'
  get '/favorite', to: 'static_pages#favorite_list'
  get '/email', to: 'static_pages#email'
  
  # users
  resources :users, only: [:new, :show, :create, :edit, :update, :destroy]
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
    # favorite
    resource :favorite, only: [:create, :destroy]
  end
end