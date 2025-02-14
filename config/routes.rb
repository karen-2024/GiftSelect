Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :post_comments, only: [:index, :destroy]
    get "/search", to: "searches#search"
  end

  scope module: :public do
    devise_for :users
    root to: "homes#top"
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :index, :edit, :update, :destroy]
    get "/search", to: "searches#search"
    get "search_tag", to: "searches#search_tag"
  end

end
