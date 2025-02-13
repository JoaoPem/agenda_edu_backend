class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :event_date

  belongs_to :class_room
  has_many :event_notifications, serializer: EventNotificationSerializer, if: -> { instance_options[:include_notifications] }
end
