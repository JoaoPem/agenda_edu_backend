class Usersbackoffice::EventNotificationsController < ApplicationController
  load_and_authorize_resource
  def index
    @notifications = current_user.event_notifications.order(created_at: :desc)
    render json: @notifications
  end
end
