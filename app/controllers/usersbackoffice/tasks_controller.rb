class Usersbackoffice::TasksController < ApplicationController
  before_action :set_task, only: [ :show ]
  before_action :authorize_task_access, only: [ :show ]

  def index
    @tasks = if current_user.student?
               Task.where(class_room: current_user.class_room)
                   .includes(:class_room, :topic, :professor)
    else
               Task.includes(:class_room, :subject, :topic, :professor).all
    end

    render json: @tasks, each_serializer: TaskSerializer, user_context: true
  end

  def show
    render json: @task
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    render json: { error: "Tarefa não encontrada" }, status: :not_found unless @task
  end

  def authorize_task_access
    return if current_user.professor? || @task.class_room == current_user.class_room

    render json: { error: "Você não tem permissão para visualizar esta tarefa." }, status: :forbidden
  end
end
