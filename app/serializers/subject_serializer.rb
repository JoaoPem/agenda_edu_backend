class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :professors
  has_many :topics, if: :include_topics?
  def include_topics?
    @instance_options[:include_topics]
  end
end
