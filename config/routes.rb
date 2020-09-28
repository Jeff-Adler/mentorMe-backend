Rails.application.routes.draw do
  
  get 'api/v1/users/:id', to: 'api/v1/users#show'  
  patch 'api/v1/users/:id', to: 'api/v1/users#update'
  get 'api/v1/users/:id/posts/', to: 'api/v1/users#retrieve_posts'
  get 'api/v1/users/:id/posts/mentor', to: 'api/v1/users#retrieve_mentor_posts'
  get 'api/v1/users/:id/posts/mentee', to: 'api/v1/users#retrieve_mentee_posts'
  get 'api/v1/users/:id/retrieve_eligibles/:mentor_type', to: 'api/v1/users#retrieve_eligible_mentors'
  get 'api/v1/users/:id/retrieve_pendings', to: 'api/v1/users#retrieve_pendings'
  patch 'api/v1/users/:id/accept_pending', to: 'api/v1/users#accept_pending'
  get 'posts/:id/messages', to: 'posts#retrieve_messages'
  post 'posts/:id/messages', to: 'posts#create_message' #not used
  post 'api/v1/users/:user_id/posts/:post_id/messages', to: 'messages#create'
  
  resources :messages
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
