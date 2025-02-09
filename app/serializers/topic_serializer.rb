class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :subject
end
