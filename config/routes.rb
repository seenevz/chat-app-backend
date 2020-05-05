Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  # resources :users
  # resources :messages
  # resources :conversations, only: [:create]

  get '/find', to: 'users#find_user'
  post '/login', to: 'auth#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
