class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at
  has_many :comments
  belongs_to :user
  has_many :user_likes, through: :comments, source: :user
end
