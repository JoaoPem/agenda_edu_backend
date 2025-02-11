class Adminsbackoffice::SubjectsController < ApplicationController
  load_and_authorize_resource

  before_action :set_subject, only: [ :show, :update, :destroy ]

  def index
    @subjects = Subject.includes(:professors).all
    render json: @subjects
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      render json: @subject, status: :created
    else
      render json: { errors: @subject.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @subject, include_topics: true
  end

  def update
    ActiveRecord::Base.transaction do
      # Se a chave :professor_ids foi enviada na requisição;
      if subject_params.key?(:professor_ids)
        # Verifica o conteúdo do parametro :professor_ids;
        if subject_params[:professor_ids].present?

          professors = User.where(id: subject_params[:professor_ids])

          missing_professors = subject_params[:professor_ids].map(&:to_i) - professors.where(role: :professor).pluck(:id)

          if missing_professors.any?
            raise ActiveRecord::RecordNotFound, "Professores não encontrados: #{missing_professors.join(', ')}"
          end

          @subject.professors = professors
        else
          @subject.professors.clear
        end
      end

      if @subject.update(subject_params.except(:professor_ids))
        render json: @subject
      else
        render json: { errors: @subject.errors.full_messages }, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def destroy
    @subject.destroy
    # render json: { message: "Subject deleted successfully" }
    head :no_content
  end


  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, professor_ids: [])
  end
end
