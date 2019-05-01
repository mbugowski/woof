# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: "home#index"
get "/help", to: "help#index", as: :help
get "/home", to: "home#index"
get "/about", to: "about#index", as: :about

resource :session, only: %i[new create destroy]
resources :users do
  member do
    get :following
    get :followers
  end
end
resources :microposts, only: %i[create destroy]
resources :relationships, only: %i[create destroy]
