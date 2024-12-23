Rails.application.routes.draw do
  root "home#index"
  resources :animes
  devise_for :users
  resources :profiles, param: :nickname, only: [ :show ] do
    collection do
      get :edit
      patch :update
    end
  end
  
  resources :friendships, only: [:index, :destroy] do
    patch 'accept', on: :member
  end

  resources :users, only: [:new, :create] do
    resource :friendships, only: [:create]
  end
end
