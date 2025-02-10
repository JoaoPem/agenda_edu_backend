class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :deadline, :class_room_id, :subject_id, :topic_id, :file_url

  def file_url
    return nil unless object.file.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.file, host: ENV.fetch("RAILS_HOST", "http://localhost:3000"))
  end
end
