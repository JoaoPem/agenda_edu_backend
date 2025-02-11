class ClassRoom < ApplicationRecord
  #has_many :users, dependent: :nullify
  has_many :students, class_name: "User"
  has_many :tasks, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
