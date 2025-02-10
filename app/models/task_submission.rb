class TaskSubmission < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id"
  belongs_to :task

  has_one_attached :file

  validates :file, attached: true, content_type: { in: "application/pdf", message: "deve ser um PDF" },
                                  size: { less_than: 10.megabytes, message: "deve ter menos de 10MB" }
end
