class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :tasks
  has_many :tasks
  
  
  attribute :tasks do
    object.tasks.sort_by{|task| task.order_number}
  end
  
end
