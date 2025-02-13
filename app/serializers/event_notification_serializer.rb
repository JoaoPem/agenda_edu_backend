class EventNotificationSerializer < ActiveModel::Serializer
  attributes :id, :message
  attribute :parent, if: -> { instance_options[:include_parent] }
  belongs_to :event

  def parent
    {
      id: object.parent.id,
      name: object.parent.name,
      email: object.parent.email
    }
  end
end
