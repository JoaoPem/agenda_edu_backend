class Usersbackoffice::FeedbacksController < ApplicationController
  before_action :set_task
  before_action :authorize_user!

  def index
    feedbacks = @task.feedbacks.includes(:user).order(created_at: :asc)
    render json: feedbacks, include: :user
  end

  def create
    feedback = @task.feedbacks.new(feedback_params)
    feedback.user = current_user

    if feedback.save
      ::FeedbackChannel.broadcast_to(@task, FeedbackSerializer.new(feedback))
      render json: feedback, status: :created
    else
      render json: { errors: feedback.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def authorize_user!
    unless @task.professor == current_user || @task.class_room.students.exists?(id: current_user.id)
      render json: { error: "Você não tem permissão para interagir com essa tarefa." }, status: :forbidden
    end
  end

  def feedback_params
    params.require(:feedback).permit(:content)
  end
end
