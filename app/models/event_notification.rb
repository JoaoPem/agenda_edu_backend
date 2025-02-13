class EventNotification < ApplicationRecord
  belongs_to :event
  belongs_to :parent, class_name: "User"
  validates :event_id, :parent_id, :message, presence: true
end
