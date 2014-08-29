Rails.application.routes.draw do
  root to: "sessions#new"
  
  resources :users, only: [ :new, :create, :edit, :update ]

  get "/login",     to: "sessions#new",     as: "login"
  post "/login",    to: "sessions#create",  as: "login_confirm"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
