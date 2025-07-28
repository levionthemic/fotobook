Rails.application.routes.draw do

  devise_for :users,
   controllers: {
     omniauth_callbacks: "users/omniauth_callbacks"
   },
   path: "",
   path_names: {
     sign_in: "login",
     sign_out: "logout",
     sign_up: "signup"
   }

  root "feed#index"
  get "discover", to: "feed#show_discover"

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :photos, except: [:index], shallow: true
    resources :albums, except: [:index], shallow: true
    resources :followers, only: [:create], controller: "follows"
    resources :followings, only: [:create], controller: "follows"

    delete "unfollow/:following_id", to: "follows#destroy", as: :unfollow
  end

  resources :likes, only: [:create, :destroy]

  namespace :admin do
    root "photos#index"
    resources :photos, only: [:index, :edit, :update, :destroy]
    resources :albums, only: [:index, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :update, :destroy]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
