class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :private, :comments, :created_at, :user, :user_likes, :user_id, :likes
  has_many :comments
  has_many :likes
  belongs_to :user
  has_many :user_likes, through: :likes, source: :user

  # attribute :user_likes do
  #   object.user.name
  # end
  attribute :created_at do
    object.created_at.strftime("%d %b %Y")
  end

  attribute :user do 
    object.user.name
  end

  attribute :user_id do
    object.user.id
  end

end
