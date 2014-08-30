Rails.application.routes.draw do

  root to: "subs#index"
  
  resources :subs 
  
  resources :posts, except: [ :destroy ] do
    resources :comments, only: [ :new ]
  end
  
  resources :comments, only: [ :create ]
  
  resources :users, only: [ :new, :create, :edit, :update ]

  get "/login",     to: "sessions#new",     as: "login"
  post "/login",    to: "sessions#create",  as: "login_confirm"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
