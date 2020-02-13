Rails.application.routes.draw do
  # resources :users
  # resources :messages
  # resources :conversations, only: [:create]

  get '/find', to: 'users#find_user'
  post '/login', to: 'auth#create'
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
