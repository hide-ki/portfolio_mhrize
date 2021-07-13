Rails.application.routes.draw do
  root 'static_pages#top'
  namespace :admin do
    root 'static_pages#top'
    resources :armors, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:destroy]
    resources :posts, only: [:destroy]
  end
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :mypages, only: [:index]
  end
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :password_resets, only: %i[new create edit update]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
