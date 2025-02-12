class ClassRoomSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :students, if: :include_students?

  def include_students?
    instance_options[:include_students] == true
  end
end
