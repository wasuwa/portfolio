Rails.application.routes.draw do
  get 'sessions/new'
  # static_pages
  get 'users/new'
  root 'static_pages#home'
  get '/password_setting', to: 'static_pages#password_setting'
  get '/email', to: 'static_pages#email'
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
end