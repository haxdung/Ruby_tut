Rails.application.routes.draw do
  get "users/new"
  root "static_pages#home"
  get  "/help", to: "static_pages#help"
  get  "/signup", to: "users#new"
  get  "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/users/:id/following", to: "follows#following"
  get "/users/:id/follower", to: "follows#followers"
  resources :users 
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts,  only: [:create, :destroy]
  resources :relationships,  only: [:create, :destroy]
end
