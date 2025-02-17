class Adminsbackoffice::EventsController < ApplicationController
  load_and_authorize_resource
  before_action :set_class_room, only: [ :create ]
  before_action :set_event, only: [ :show, :update, :destroy ]

  def create
    @event = @class_room.events.build(event_params)

    if @event.save
      render json: @event, serializer: EventSerializer, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @events = Event.includes(:class_room).order(created_at: :desc)
    if stale?(etag: @events)
      render json: @events, each_serializer: EventSerializer
    end
  end

  def show
    if stale?(etag: @event)
      render json: @event, serializer: EventSerializer, include_notifications: true, include_parent: true
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, serializer: EventSerializer, status: :ok
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_class_room
    @class_room = ClassRoom.find(params[:class_room_id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :event_date, :class_room_id)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
