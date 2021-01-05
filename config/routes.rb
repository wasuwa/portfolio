Rails.application.routes.draw do
  root 'static_pages#home'
  get '/settings', to: 'static_pages#settings', as: 'settings'
  # as: は目印のようなもの。link_toなどでURLを書く際に便利
end