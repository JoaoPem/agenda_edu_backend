Rails.application.routes.draw do
  post "login", to: "authentication#login"

  namespace :adminsbackoffice do
    resources :users, only: [ :create, :index, :show, :update, :destroy ] do
      member do
        post :add_student
        delete :remove_student
      end
    end

    resources :subjects do
      resources :topics, only: [ :create, :update, :destroy ]
    end

    resources :topics, only: [ :index, :show ]
    resources :class_rooms

    resources :tasks, only: [ :index, :create, :destroy, :update, :show ] do
      resources :task_submissions, only: [ :index ]
    end

    resources :events
  end

  namespace :usersbackoffice do
    resources :users, only: [ :show, :update ]

    resources :tasks, only: [ :index, :show ] do
      resources :task_submissions, only: [ :create, :update, :show ]
      resources :feedbacks, only: [ :index, :create ]
    end

    resources :task_submissions, only: [ :index ]

    get "/class_rooms/classmate", to: "class_rooms#show_classmate"

    resources :event_notifications, only: [ :index, :show ]
  end

  match "*unmatched", to: "application#route_not_found", via: :all, constraints: lambda { |req|
    !req.path.start_with?("/rails/active_storage/")
  }
end
