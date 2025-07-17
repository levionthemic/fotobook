Rails.application.routes.draw do
  root "feed#index"

  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    sign_up: "signup"
  }

  get "discover", to: "feed#show_discover"

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :photos, except: [:index], shallow: true
    resources :albums, except: [:index], shallow: true

    resources :followers, only: [:create, :destroy], controller: "follows"
    resources :followings, only: [:create, :destroy], controller: "follows"
    member do
      patch :follower
      patch :following
    end
  end

  resources :likes, only: [:create, :destroy]

  namespace :admin do
    root "photos#index"
    resources :photos, only: [:index, :edit, :update]
    resources :albums, only: [:index, :edit, :update]
    resources :users, only: [:index, :edit, :update]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
