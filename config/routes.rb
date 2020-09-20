Rails.application.routes.draw do
  
  patch 'api/v1/users/:id', to: 'api/v1/users#update'
  get 'api/v1/users/:id/retrieve_eligibles', to: 'api/v1/users#retrieve_eligible_mentors'
  get 'api/v1/users/:id/retrieve_pendings', to: 'api/v1/users#retrieve_pendings'

  resources :answers
  resources :questions
  resources :posts
  resources :connections
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end
end
