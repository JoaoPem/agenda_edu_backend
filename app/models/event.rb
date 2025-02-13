class Event < ApplicationRecord
  belongs_to :class_room
  has_many :event_notifications, dependent: :destroy

  validates :title, :description, :event_date, presence: true

  after_create :notify_parents
  after_update :notify_parents_on_update

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

  def notify_parents_on_update
    # Caso a turma do evento tenha sido alterada
    if class_room_id_previously_changed?
      old_class_room_id = class_room_id_before_last_save
      old_class_room = ClassRoom.find_by(id: old_class_room_id)

      if old_class_room
        old_students = old_class_room.students
        old_parents = old_students.flat_map(&:parents).uniq

        old_parents.each do |parent|
          notification = EventNotification.create!(
            parent: parent,
            event: self,
            message: "O evento '#{title}' foi cancelado para a sua turma."
          )

          ActionCable.server.broadcast(
            "event_notifications_#{parent.id}",
            { message: notification.message, event: self }
          )
        end
      end
    end

    # Notifica os pais da turma atual
    notify_parents
  end
end
