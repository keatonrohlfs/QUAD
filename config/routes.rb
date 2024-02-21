=======
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Root route
  root "users#login"

  # User routes for login and signup
  get "/login", to: "users#login"
  
  # Sign-up process routes
  get '/signup', to: 'users#signup'
  post '/profilepic', to: 'users#profilepic'
  post '/aboutyou', to: 'users#aboutyou'
  post '/finalize', to: 'users#create'

  # Listings resource
  resources :listings
end

