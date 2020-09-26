Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get '/find', to: 'users#find_user'
  post '/login', to: 'auth#login'
  post '/signup', to: 'auth#create'
  delete '/logout', to: 'auth#logout'
  get '/verify', to: 'auth#verify_user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
