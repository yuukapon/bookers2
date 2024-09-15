Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  
  get "/home/about", to: "homes#about", as: "about"
  
  resources :books, only: [:create, :index, :edit, :update, :show, :destroy]
  resources :users, only: [:index, :edit, :show, :update]
end

