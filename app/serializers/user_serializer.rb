class UserSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :blogs
  has_many :comments
  has_many :liked_blogs, through: :likes, source: :blog
end
