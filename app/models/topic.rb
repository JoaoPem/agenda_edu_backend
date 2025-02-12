class Topic < ApplicationRecord
  belongs_to :subject
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
