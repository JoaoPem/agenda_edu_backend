class Topic < ApplicationRecord
  belongs_to :subject

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
