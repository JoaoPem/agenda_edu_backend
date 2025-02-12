class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :profile_picture_url

  def profile_picture_url
    return nil unless object.profile_picture.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.profile_picture, host: ENV.fetch("RAILS_HOST", "http://localhost:3000"))
  end
end
