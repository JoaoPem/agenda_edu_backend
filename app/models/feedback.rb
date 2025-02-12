class Feedback < ApplicationRecord
  belongs_to :task
  belongs_to :student, class_name: "User"

  validates :content, presence: true
end
