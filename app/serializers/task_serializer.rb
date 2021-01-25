class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :finished, :list_id, :order_number
  # has_one :list

  attribute :list_id do
    object.list.id
  end


end
