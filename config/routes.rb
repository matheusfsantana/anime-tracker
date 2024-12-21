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
end
