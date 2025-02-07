Rails.application.routes.draw do
  post "login", to: "authentication#login"

  namespace :adminsbackoffice do
    resources :users, only: [ :create, :index, :show, :update, :destroy ]
  end

  namespace :usersbackoffice do
    resources :users, only: [ :show, :update ]
  end
end
