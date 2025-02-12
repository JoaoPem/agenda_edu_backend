class TaskSerializer < ActiveModel::Serializer
  attributes :id, :professor_id, :title, :description, :deadline, :class_room_id, :subject_id, :topic_id, :file_url, :feedbacks

  attribute :status, if: :user_context?

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

  def user_context?
    instance_options[:user_context] == true
  end

  def feedbacks
    object.feedbacks.includes(:student).order(created_at: :asc).map do |feedback|
      FeedbackSerializer.new(feedback)
    end
  end
end
