Rails.application.routes.draw do
  post "login", to: "authentication#login"

  namespace :adminsbackoffice do
    resources :users, only: [ :create, :index, :show, :update, :destroy ]
    resources :subjects do
      resources :topics, only: [ :create, :update, :destroy ]
    end
    resources :topics, only: [ :index, :show ]
    resources :class_rooms
    resources :tasks, only: [ :index, :create, :destroy, :update ] do
      resources :task_submissions, only: [ :index ]
    end
  end

  namespace :usersbackoffice do
    resources :users, only: [ :show, :update ]
    resources :tasks, only: [ :index ] do
      resources :task_submissions, only: [ :index, :create, :update, :show ]
    end
  end

  match "*unmatched", to: "application#route_not_found", via: :all
end
