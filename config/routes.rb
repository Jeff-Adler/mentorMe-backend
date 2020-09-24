Rails.application.routes.draw do
  
  
  get 'api/v1/users/:id', to: 'api/v1/users#show'  
  patch 'api/v1/users/:id', to: 'api/v1/users#update'
  get 'api/v1/users/:id/posts/mentor', to: 'api/v1/users#retrieve_mentor_posts'
  get 'api/v1/users/:id/posts/mentee', to: 'api/v1/users#retrieve_mentee_posts'
  get 'api/v1/users/:id/retrieve_eligibles/:mentor_type', to: 'api/v1/users#retrieve_eligible_mentors'
  get 'api/v1/users/:id/retrieve_pendings', to: 'api/v1/users#retrieve_pendings'
  patch 'api/v1/users/:id/accept_pending', to: 'api/v1/users#accept_pending'
  
  resources :mentee_experiences
  resources :mentor_experiences
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
