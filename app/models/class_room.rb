class ClassRoom < ApplicationRecord
  has_many :students, class_name: "User", dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :events, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
