class TaskSubmissionSerializer < ActiveModel::Serializer
  attributes :id, :description, :file_url, :status, :student

  belongs_to :task

  def status
    TaskStatus.find_by(student: object.student, task: object.task)&.status
  end

  def file_url
    return nil unless object.file.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.file, host: ENV.fetch("RAILS_HOST", "http://localhost:3000"))
  end

  def student
    {
      id: object.student.id,
      name: object.student.name,
      email: object.student.email
    }
  end
end
