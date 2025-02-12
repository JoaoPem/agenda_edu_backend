class TaskSerializer < ActiveModel::Serializer
  attributes :id, :professor_id, :title, :description, :deadline, :class_room_id, :subject_id, :topic_id, :file_url

  # É chamado no controller do usuário;
  attribute :status, if: :user_status?
  has_many :feedbacks, if: :include_feedbacks?, serializer: FeedbackSerializer
  has_many :task_submissions, if: :include_submissions?


  def subject_id
    object.topic.subject_id
  end

  def file_url
    return nil unless object.file.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.file, host: ENV.fetch("RAILS_HOST", "http://localhost:3000"))
  end

  def status
    TaskStatus.find_by(student: current_user, task: object)&.status
  end

  def user_status?
    instance_options[:user_status] == true
  end

  def include_feedbacks?
    instance_options[:include_feedbacks] == true
  end

  def include_submissions?
    instance_options[:include_submissions] == true
  end

end
