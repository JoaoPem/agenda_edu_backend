class Usersbackoffice::TasksController < ApplicationController
  before_action :authorize_access
  before_action :set_task, only: [ :show ]

  def index
    @tasks = Task.where(class_room: current_user.class_room).includes(:class_room, :topic, :professor)

    render json: @tasks, each_serializer: TaskSerializer, user_status: true
  end

  def show
    render json: @task, each_serializer: TaskSerializer, include_feedbacks: true, user_status: true
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    render json: { error: "Tarefa não encontrada" }, status: :not_found unless @task
  end

  def authorize_access
    return render json: { error: "Acesso negado. Apenas estudantes podem acessar esta funcionalidade." }, status: :forbidden unless current_user.student?

    if params[:id].present? && @task && @task.class_room != current_user.class_room
      render json: { error: "Você não tem permissão para visualizar esta tarefa." }, status: :forbidden
    end
  end
end
