SriRails::Application.routes.draw do

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  root :to => 'home#index'
  resources :users
  resources :clubs
  resources :requests
  resources :transactions
  resources :votes

end
