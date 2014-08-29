Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/show'

  root to: "subs#index"
  
  resources :subs do
    resources :posts, only: [ :new, :create ]
  end
  resources :posts, except: [ :new, :index, :create ]
  
  resources :users, only: [ :new, :create, :edit, :update ]

  get "/login",     to: "sessions#new",     as: "login"
  post "/login",    to: "sessions#create",  as: "login_confirm"
  delete "/logout", to: "sessions#destroy", as: "logout"
end
