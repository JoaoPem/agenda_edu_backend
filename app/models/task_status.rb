class TaskStatus < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :task

  enum :status, [ :novo, :em_progresso, :concluido ]

  validates :status, presence: true
end
