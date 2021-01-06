Rails.application.routes.draw do
  root 'static_pages#home'
  get '/account_setting', to: 'static_pages#account_setting', as: 'account_setting'
  get '/password_setting', to: 'static_pages#password_setting', as: 'passoword_setting'
  get '/login', to: 'static_pages#login', as: 'login'
  get '/sign_up', to: 'static_pages#sign_up', as: 'sign_up'
  get '/email', to: 'static_pages#email', as: 'email'
  # as: は目印のようなもの。link_toなどでURLを書く際に便利
end