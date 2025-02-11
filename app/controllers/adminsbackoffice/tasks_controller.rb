class Adminsbackoffice::TasksController < ApplicationController
  load_and_authorize_resource

  before_action :set_task, only: [ :update, :destroy ]

  def index
    # tasks?filter=my_tasks
    if params[:filter] == "my_tasks" && current_user.professor?
      @tasks = Task.includes(:class_room, :topic, :professor).where(professor_id: current_user.id)
    else
      @tasks = Task.includes(:class_room, :topic, :professor).all
    end
    render json: @tasks
  end

  def create
    topic = Topic.includes(:subject).find_by(id: task_params[:topic_id])

    if topic.nil?
      return render json: { error: "O tópico informado não existe" }, status: :not_found
    end

    unless topic.subject.professors.exists?(id: current_user.id)
      return render json: { error: "Você não tem permissão para criar uma tarefa neste tópico" }, status: :forbidden
    end

    @task = Task.new(task_params)
    @task.professor = current_user

    unless params[:task][:file].present?
      return render json: { errors: [ "O arquivo PDF é obrigatório" ] }, status: :unprocessable_entity
    end

    @task.file.attach(params[:task][:file])

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    ActiveRecord::Base.transaction do
      if params[:task][:file].present?
        @task.file.purge if @task.file.attached?
        @task.file.attach(params[:task][:file])
      end

      if @task.update(task_params.except(:file).compact_blank)
        render json: @task
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :class_room_id, :topic_id, :file)
  end
end
