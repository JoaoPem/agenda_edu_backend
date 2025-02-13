class EventNotificationSerializer < ActiveModel::Serializer
  attributes :id, :message

  belongs_to :event
end
