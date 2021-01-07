Rails.application.routes.draw do
  root 'static_pages#home'
  get '/account_setting', to: 'static_pages#account_setting'
  get '/password_setting', to: 'static_pages#password_setting'
  get '/login', to: 'static_pages#login'
  get '/sign_up', to: 'static_pages#sign_up'
  get '/email', to: 'static_pages#email'
  get '/profile', to: 'static_pages#profile'
  get '/other_profile', to: 'static_pages#other_profile'
  get '/new_articles', to: 'static_pages#new_articles_list'
  get '/favorite', to: 'static_pages#favorite_list'
end