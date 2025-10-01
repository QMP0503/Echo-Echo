Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Authentication routes
  get "login", to: "auth#login"
  post "login", to: "auth#authenticate"
  get "signup", to: "auth#signup"
  post "signup", to: "auth#create_user"
  delete "logout", to: "auth#logout"

  # Defines the root path route ("/")
  root "echos#index"

  resources :echos do
    resources :echo_dates, except: [ :index, :show ]
  end
end
