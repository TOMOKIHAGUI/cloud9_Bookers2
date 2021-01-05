Rails.application.routes.draw do

  devise_for :users
  root to: 'home#top'
  get 'home/about' => 'home#about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
