Rails.application.routes.draw do

  devise_for :users
  root to: 'home#top'
  get 'home/about' => 'home#about'
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :followings
      get :followers
    end
  end

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  post 'follow/:id' => 'relationships#create', as: 'follow'
  delete 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
  
  get 'search/search' => 'search#search', as: 'search'

end
