Rails.application.routes.draw do
  root "feed#index"

  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: "logout",
    sign_up: "signup"
  }


  # get "login", to: "auth#login"
  # post "login", to: "auth#loginPost"
  # get "signup", to: "auth#signup"
  # post "signup", to: "auth#signupPost"
  # delete "/logout", to: "auth#logout", as: :logout

  get "discover", to: "feed#show_discover"
  # get "profile", to: "profile#index"

  resources :users, only: [ :show, :edit, :update, :destroy ] do
    resources :photos, except: [ :index ], shallow: true
    resources :albums, except: [ :index ], shallow: true

    member do
      get :photos
      get :albums
      get :followers
      get :followings
    end
  end


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
