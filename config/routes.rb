Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "/login", to: "users#login"
  get "/signup", to: "users#signup"
  get "/aboutyou", to: "users#aboutyou"
  get "/profilepic", to: "users#profilepic"

  get "/signup", to: "users#new"
  post "/users", to: "users#create"
  get '/login_success', to: 'pages#login_success'
  get "/listing", to: "pages#listing"
  
  # Defines the root path route ("/")
  root "users#login"

  resources :listings

end
