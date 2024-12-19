Rails.application.routes.draw do
  root "home#index"
  resources :animes
  devise_for :users
  resources :profile, param: :nickname, only: [ :show ]
end
