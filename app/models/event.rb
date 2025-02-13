class Event < ApplicationRecord
  belongs_to :class_room
  has_many :event_notifications, dependent: :destroy

  validates :title, :description, :event_date, presence: true

  after_create :notify_parents

  private

  def notify_parents
    students = class_room.students
    parents = students.flat_map(&:parents).uniq

    parents.each do |parent|
      notification = EventNotification.create!(
        parent: parent,
        event: self,
        message: "Novo evento: #{title} em #{event_date.strftime('%d/%m/%Y')}"
      )

      ActionCable.server.broadcast(
        "event_notifications_#{parent.id}",
        { message: notification.message, event: self }
      )
    end
  end
end
