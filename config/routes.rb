Rails.application.routes.draw do
  
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  
  #root "passthrough#index"
  root :to => 'passthrough#index'

  post "/sign_up", to: "users#create"
  get "/sign_up", to: "users#new"

  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/login", to: "sessions#new"

  get '/clear_flash', to: 'application#clear_flash'

  get "/account/admin", to: "users#profile_admin", as: 'account_admin'
  get "/account/user", to: "users#profile_normal", as: 'account_user'
  put "/account/settings", to: "users#update"
  get "/account/settings", to: "users#settings"
  delete "/account", to: "users#destroy"

  get "/listings/new", to: "listings#new" 
  post "/listings", to: "listings#create"
  delete "/listings/:id", to: "listings#destroy"
 

  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token
  resources :passwords, only: [:create, :edit, :new, :update], param: :password_reset_token
  resources :active_sessions, only: [:destroy] do
    collection do
      delete "destroy_all"
    end
  end
  resources :listings, only: [:new, :create, :show, :index, :edit, :update, :delete]
end
