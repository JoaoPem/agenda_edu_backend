class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :student

  def student
    {
      id: object.student.id,
      name: object.student.name,
      email: object.student.email
    }
  end
end
