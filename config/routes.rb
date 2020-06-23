Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "recipes#index"
  namespace :recipes do
    resources :searches, only: :index
  end
  resources :recipes, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :show, :destroy]
    resources :reports, only: [:new, :create, :show]
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

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
end