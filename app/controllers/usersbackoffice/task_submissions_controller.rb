class Usersbackoffice::TaskSubmissionsController < ApplicationController
  before_action :set_task, only: [ :create ]
  before_action :authorize_student_submission, only: [ :create ]

  def create
    if TaskSubmission.exists?(student_id: current_user.id, task_id: @task.id)
      return render json: { error: "Você já enviou uma resposta para esta atividade" }, status: :unprocessable_entity
    end

    @submission = @task.task_submissions.build(task_submission_params)
    @submission.student = current_user

    if params[:task_submission][:file].blank?
      return render json: { error: "O arquivo PDF é obrigatório" }, status: :unprocessable_entity
    end

    @submission.file.attach(params[:task_submission][:file])

    if @submission.save
      task_status = TaskStatus.find_or_initialize_by(student: current_user, task: @task)
      task_status.status = "concluido"
      task_status.save
      render json: @submission, status: :created
    else
      render json: { errors: @submission.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def task_submission_params
    params.require(:task_submission).permit(:description, :file)
  end

  def authorize_student_submission
    unless @task.class_room_id == current_user.class_room_id
      render json: { error: "Você não pode enviar uma resposta para esta atividade, pois ela não pertence à sua turma." }, status: :forbidden
    end
  end
end
