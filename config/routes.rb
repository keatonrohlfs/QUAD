Rails.application.routes.draw do
  
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  root "static_pages#home"

  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token

  post "sign_up", to: "users#create"
  get "sign_up", to: "users#new"

  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"

end
