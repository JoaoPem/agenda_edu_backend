class Usersbackoffice::EventNotificationsController < ApplicationController
  load_and_authorize_resource
  def index
    @notifications = current_user.event_notifications.order(created_at: :desc)
    render json: @notifications, each_serializer: EventNotificationSerializer
  end

  def show
    @notification = EventNotification.find(params[:id])
    authorize! :read, @notification
    render json: @notification, serializer: EventNotificationSerializer
  end
end
