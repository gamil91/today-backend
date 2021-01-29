class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :lists
  has_many :blogs
  has_many :comments
  has_many :liked_blogs, through: :likes, source: :blog
  # has_many :lists
  has_many :tasks, through: :lists

  def lists 
    object.lists.sort_by{|list| list.order_number}
  end
  
 

end
