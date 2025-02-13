class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :event_date

  belongs_to :class_room
end
