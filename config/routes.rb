Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  get '/search' => 'searchs#search', as: 'search'
  resources :users, only: [:show,:index,:edit,:update] do
    member do
      get :followed, :followers
    end
  end
  resources :follow_relationships, only: [:create, :destroy]
  
  resources :books do
    resource :favorites, only: [:create, :destroy, :show]
    resources :book_comments, only: [:create, :destroy, :show]
  end
  resources :favorites, only: [:index]
end