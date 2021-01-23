class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :finished, :list_id
  # has_one :list

  attribute :list_id do
    object.list.id
  end


end
