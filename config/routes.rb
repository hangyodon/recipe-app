Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  namespace :recipes do
    resources :searches, only: :index
  end
  resources :recipes, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :show]
    collection do
      get 'main'
      get 'side'
      get 'soup'
    end
  end
  resources :users, only: [:show] do
    member do
      get :favorites
    end
  end
  
end