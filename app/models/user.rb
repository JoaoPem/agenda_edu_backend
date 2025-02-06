class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }

  enum :role, [ :admin, :professor, :student ]

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  private

  def password_required?
    new_record? || password.present?
  end
end
