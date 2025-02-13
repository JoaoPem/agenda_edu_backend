class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user

  def user
    {
      id: object.user.id,
      name: object.user.name,
      email: object.user.email
    }
  end
end
