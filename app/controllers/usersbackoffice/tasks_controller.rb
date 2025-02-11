class Usersbackoffice::TasksController < ApplicationController
  def index
    @tasks = if current_user.student?
               Task.where(class_room: current_user.class_room).includes(:class_room, :topic, :professor)
    else
               Task.includes(:class_room, :subject, :topic, :professor).all
    end

    render json: @tasks, each_serializer: TaskSerializer, user_context: true
  end
end
