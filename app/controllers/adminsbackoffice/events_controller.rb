class Adminsbackoffice::EventsController < ApplicationController
  load_and_authorize_resource
  before_action :set_class_room, only: [ :create ]
  before_action :set_event, only: [ :show ]

  def create
    @event = @class_room.events.build(event_params)

    if @event.save
      # render json: { message: "Evento criado com sucesso", event: EventSerializer.new(@event) }, status: :created
      render json: @event, serializer: EventSerializer, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @events = Event.includes(:class_room).order(created_at: :desc)
    if stale?(etag: @events, last_modified: @events.maximum(:updated_at))
      render json: @events, each_serializer: EventSerializer
    end
  end

  def show
    if stale?(etag: @event, last_modified: @event.updated_at)
      render json: @event, serializer: EventSerializer, include_notifications: true, include_parent: true
    end
  end

  private

  def set_class_room
    @class_room = ClassRoom.find(params[:class_room_id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :event_date)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
