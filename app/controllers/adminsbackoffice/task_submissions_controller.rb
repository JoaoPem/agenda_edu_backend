class Adminsbackoffice::TaskSubmissionsController < ApplicationController
  before_action :set_task

  def index
    unless @task.professor == current_user
      render json: { error: "Você não tem permissão para visualizar as submissões desta tarefa." }, status: :forbidden
      return
    end

    @submissions = @task.task_submissions.includes(:student)
    render json: @submissions
  end

  private

  def set_task
    @task = Task.find_by(id: params[:task_id])

    if @task.nil?
      render json: { error: "A tarefa informada não existe" }, status: :not_found
    end
  end
end
