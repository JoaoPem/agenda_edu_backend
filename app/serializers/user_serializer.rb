class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :profile_picture_url
end
