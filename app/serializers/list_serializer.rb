class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :tasks, :order_number
  has_many :tasks
  
  
  attribute :tasks do
    object.tasks.sort_by{|task| task.order_number}
  end
  
end
