SriRails::Application.routes.draw do

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  root :to => 'home#index'
  resources :users
  resources :clubs
  resources :requests do
    collection do
      get 'search'
    end
  end
  resources :transactions
  resources :votes
  resources :deposits

  get '/clubs/:id/join' => 'clubs#join', as: :join_club

end
