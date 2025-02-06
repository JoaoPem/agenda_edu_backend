class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { minimum: 8, maximum: 100 }

  enum role: [ :admin, :professor, :student ]
  validates :role, presence: true
end
