Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"

  resources :posts do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :index, :edit, :update, :destroy]

  get "/search", to: "searches#search"

end
