Rails.application.routes.draw do
  post "login", to: "authentication#login"

  namespace :adminsbackoffice do
    resources :users, only: [ :create, :index, :show, :update, :destroy ]
    resources :subjects, only: [ :create, :index, :update ]
  end

  namespace :usersbackoffice do
    resources :users, only: [ :show, :update ]
  end

  match "*unmatched", to: "application#route_not_found", via: :all
end
