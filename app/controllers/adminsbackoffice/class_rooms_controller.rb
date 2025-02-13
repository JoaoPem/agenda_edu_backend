class Adminsbackoffice::ClassRoomsController < ApplicationController
  load_and_authorize_resource

  before_action :set_class_room, only: [ :show, :update, :destroy ]

  def index
    # @class_room = ClassRoom.new(class_room_params)
    @class_rooms = ClassRoom.all
    if stale?(etag: @class_rooms, last_modified: @class_rooms.maximum(:updated_at))
      render json: @class_rooms
    end
  end

  def create
    @class_room = ClassRoom.new(class_room_params)
    if @class_room.save
      render json: @class_room, status: :created
    else
      render json: { errors: @class_room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    ActiveRecord::Base.transaction do
      # Se a chave :student_ids foi enviada na requisição;
      if class_room_params.key?(:student_ids)
        # Verifica o conteúdo do parametro :student_ids;
        if class_room_params[:student_ids].present?

          students = User.where(id: class_room_params[:student_ids], role: :student)

          missing_students = class_room_params[:student_ids].map(&:to_i) - students.pluck(:id)
          if missing_students.any?
            raise ActiveRecord::RecordNotFound, "Estudantes não encontrados: #{missing_students.join(', ')}"
          end

          students.update_all(class_room_id: @class_room.id)
        else
          User.where(class_room_id: @class_room.id).update_all(class_room_id: nil)
        end
      end

      if @class_room.update(class_room_params.except(:student_ids))
        render json: @class_room
      else
        render json: { errors: @class_room.errors.full_messages }, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def destroy
    @class_room.destroy
    head :no_content
  end

  def show
    if stale?(etag: @class_room, last_modified: @class_room.updated_at)
      render json: @class_room, serializer: ClassRoomSerializer, include_students: true
    end
  end

  private

  def class_room_params
    params.require(:class_room).permit(:name, student_ids: [])
  end

  def set_class_room
    @class_room = ClassRoom.find(params[:id])
  end
end
