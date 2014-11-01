Rails.application.routes.draw do
  root  'about#index'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/about', to: 'about#index', via:'get'
  match '/search', to: 'search#index', via: 'get'
  resources :users do
    member do
      get :following, :followers, :favorite
    end
  end
  resources :tweets do
    member do
      get :favorite
      post :reply
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
