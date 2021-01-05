Rails.application.routes.draw do
  root 'static_pages#home'
  get '/account_setting', to: 'static_pages#account_setting', as: 'account_setting'
  # as: は目印のようなもの。link_toなどでURLを書く際に便利
end