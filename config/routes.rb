Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    collection do
      post 'search_movie' => 'posts#search_movie'
      get 'search' => 'posts#search'
    end
    resources :comments, only: [:create]
    member do
      post 'like' => 'likes#create'
      delete 'unlike' => 'likes#destroy'
    end
  end
  resources :users, only: [:show, :edit, :update]
end
