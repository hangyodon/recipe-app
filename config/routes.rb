Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  namespace :recipes do
    resources :searches, only: :index
  end
  resources :recipes, only: [:index, :new, :create, :destroy, :edit, :update, :show]
  resources :users, only: :show
  resources :favorites, only: [:create, :destroy]
end