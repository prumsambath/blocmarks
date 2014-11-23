Rails.application.routes.draw do
  devise_for :users
  mount_griddler

  get 'hashtags/:hashtag', to: 'bookmarks#index', as: 'hashtag'
  resources :users, only: [:show, :update, :destroy]
  resources :hashtags, only: [:index]
  resources :bookmarks do
    resources :favorites, only: [:create, :destroy]
  end

  root to: "welcome#index"
end
