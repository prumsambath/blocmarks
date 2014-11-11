Rails.application.routes.draw do
  devise_for :users
  mount_griddler

  resources :users, only: [:show]
  resources :bookmarks, only: [:index, :show]
  resources :hashtags, only: [:show]

  root to: "welcome#index"
end
