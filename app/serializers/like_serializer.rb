class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :blog_id
  belongs_to :user
  belongs_to :blog


end
