Rails.application.routes.draw do
  # static_pages
  get 'users/new'
  root 'static_pages#home'
  get '/account_setting', to: 'static_pages#account_setting'
  get '/password_setting', to: 'static_pages#password_setting'
  get '/login', to: 'static_pages#login'
  get '/email', to: 'static_pages#email'
  get '/profile/article_details', to: 'static_pages#article_details'
  get '/profile/my_article_details', to: 'static_pages#my_article_details'
  get '/profile/article_posting', to: 'static_pages#article_posting'
  get '/other_profile', to: 'static_pages#other_profile'
  get '/new_articles', to: 'static_pages#new_articles_list'
  get '/favorite', to: 'static_pages#favorite_list'
  resources :users
end