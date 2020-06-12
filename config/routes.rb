Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  namespace :recipes do
    resources :searches, only: :index
  end
  resources :recipes, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :favorites, only: [:create, :destroy]
  end
  resources :users, only: :show
end