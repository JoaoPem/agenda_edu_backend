class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :professors, if: :include_professors?
  has_many :topics, if: :include_topics?

  def include_professors?
    @instance_options[:include_professors]
  end

  def include_topics?
    @instance_options[:include_topics] == true
  end
end
