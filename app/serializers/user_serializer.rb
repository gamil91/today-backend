class UserSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :blogs
  has_many :comments
  has_many :liked_blogs, through: :likes, source: :blog
  has_many :lists
  has_many :tasks, through: :lists
end
