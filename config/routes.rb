Rails.application.routes.draw do
  devise_for :users
  root to: "places#index"
  resources :users, only: :show
  resources :places do
    resources :comments, only: :create
  end
end
