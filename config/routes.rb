Rails.application.routes.draw do
  get 'dashboard/index'

  root "users#index"

  get :signup, to: "users#new"
  post :signup, to: "users#create"

  get :login, to: "sessions#new"
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy"
  resources :roles
  resources :users
  resources :permissions, only: [:index, :show]
end
