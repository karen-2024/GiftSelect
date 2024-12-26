Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
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
  end

end
