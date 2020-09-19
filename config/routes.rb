Rails.application.routes.draw do
  resources :add_mentee_name_to_posts
  resources :add_mentor_name_to_posts
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
