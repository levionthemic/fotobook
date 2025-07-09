Rails.application.routes.draw do
  root "feed#index"

  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    sign_up: "signup"
  }

  get "discover", to: "feed#show_discover"
  # get "profile", to: "profile#index"

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :photos, except: [:index], shallow: true
    resources :albums, except: [:index], shallow: true

    resources :followers, only: [:create, :destroy], controller: "follows"
    resources :followings, only: [:create, :destroy], controller: "follows"
    member do
      get :photos
      get :albums
      get :followers
      get :followings

      patch :follower
      patch :following
    end
  end

  get "admin/photos", to: "photos#admin_show_photos"
  get "admin/albums", to: "albums#admin_show_albums"
  get "admin/users", to: "users#admin_show_users"
  get "admin/users/:id", to: "users#admin_show_user_detail"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
