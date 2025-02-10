class ClassRoom < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
