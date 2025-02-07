class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_picture

  before_save { email.downcase! }

  enum :role, [ :admin, :professor, :student ]

  attr_accessor :current_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}\z/,
    message: "deve ter pelo menos 8 caracteres, incluindo uma letra maiúscula, uma letra minúscula, um número e um caractere especial"
  }, if: :password_required?

  validates :password_confirmation, presence: true, if: :password_required?

  validate :validate_current_password, on: :update


  private

  def profile_picture_url
    return nil unless profile_picture.attached?

    Rails.application.routes.url_helpers.rails_blob_url(profile_picture, host: ENV.fetch("RAILS_HOST", "http://localhost:3000"))
  end

  def password_required?
    new_record? || password.present?
  end

  def validate_current_password
    if current_password.blank?
      errors.add(:current_password, "é obrigatória")
      return
    end

    # Recarrega o usuário do banco para garantir que a senha seja validada corretamente antes da atualização;
    user_in_db = User.find(id)
    unless user_in_db.authenticate(current_password)
      errors.add(:current_password, "está incorreta")
    end
  end
end
