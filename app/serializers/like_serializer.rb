class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :blog_id
  has_one :user
  has_one :blog
end
