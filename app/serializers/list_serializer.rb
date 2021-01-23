class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :tasks
  has_many :tasks
  # has_one :user
end
