class Task < ApplicationRecord
  belongs_to :class_room
  belongs_to :subject
  belongs_to :topic
  belongs_to :professor, class_name: "User"

  has_one_attached :file
  has_many :task_submissions, dependent: :destroy
  has_many :task_statuses, dependent: :destroy

  validates :title, :description, :deadline, presence: true
  validates :file, attached: true, content_type: { in: "application/pdf", message: "deve ser um PDF" }, size: { less_than: 10.megabytes, message: "deve ter menos de 10MB" }

  after_create :assign_task_statuses

  private

  def assign_task_statuses
    class_room.students.each do |student|
      TaskStatus.create!(task: self, student: student, status: :novo)
    end
  end

end
