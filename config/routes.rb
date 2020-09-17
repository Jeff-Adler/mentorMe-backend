Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :posts
  resources :connections
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
