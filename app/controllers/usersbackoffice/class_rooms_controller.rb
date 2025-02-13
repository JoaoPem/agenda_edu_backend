class Usersbackoffice::ClassRoomsController < ApplicationController
  before_action :authorize_student

  def show_classmate
    student = current_user

    if student.class_room.nil?
      render json: { message: "Aluno não está em nenhuma sala" }, status: :not_found
      return
    end

    classmates = student.class_room.students.where.not(id: student.id).as_json(only: [ :name, :email ])

    if stale?(etag: classmates)
      render json: classmates
    end

  end

  private

  def authorize_student
    unless current_user&.student?
      render json: { error: "Acesso negado: apenas estudantes podem acessar esta funcionalidade" }, status: :forbidden
    end
  end
end
