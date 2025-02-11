class Subject < ApplicationRecord
  has_and_belongs_to_many :professors, class_name: "User"
  has_many :topics, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
