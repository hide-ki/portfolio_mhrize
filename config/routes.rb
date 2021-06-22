Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
