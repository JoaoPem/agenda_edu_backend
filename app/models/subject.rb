class Subject < ApplicationRecord
  has_and_belongs_to_many :professors,
                          class_name: "User",
                          join_table: "professors_subjects",
                          foreign_key: "subject_id",
                          association_foreign_key: "professor_id"

  has_many :topics, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
