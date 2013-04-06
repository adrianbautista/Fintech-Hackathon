SriRails::Application.routes.draw do

  devise_for :users

  root :to => 'home#index'
  resources :users
  resources :clubs
  resources :requests
  resources :transactions
  resources :votes

end
