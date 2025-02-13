class User < ApplicationRecord
  has_secure_password

  has_one_attached :profile_picture
  has_and_belongs_to_many :subjects_as_professor,
                          class_name: "Subject",
                          join_table: "professors_subjects",
                          association_foreign_key: "subject_id",
                          foreign_key: "professor_id"

  belongs_to :class_room, optional: true
  has_many :tasks, foreign_key: "professor_id", dependent: :destroy
  has_many :task_submissions, dependent: :nullify
  has_many :task_statuses, foreign_key: :student_id, dependent: :destroy
  has_many :feedbacks, dependent: :destroy


  has_and_belongs_to_many :children,
                          class_name: "User",
                          join_table: "parents_students",
                          foreign_key: "parent_id",
                          association_foreign_key: "student_id"

  has_and_belongs_to_many :parents,
                          class_name: "User",
                          join_table: "parents_students",
                          foreign_key: "student_id",
                          association_foreign_key: "parent_id"

  has_many :event_notifications, foreign_key: :parent_id, dependent: :destroy


  before_save { email.downcase! }

  enum :role, [ :admin, :professor, :student, :parent ]

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
