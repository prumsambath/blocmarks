Rails.application.routes.draw do
  devise_for :users
  mount_griddler

  resources :users, only: [:show, :update, :destroy]
  resources :hashtags, only: [:show, :index]
  resources :bookmarks do
    resources :favorites, only: [:create, :destroy]
  end
  resources :hashtags, only: [:show]

  root to: "welcome#index"
end
