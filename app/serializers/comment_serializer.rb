class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user_id, :blog_id, :created_at
  # has_one :user
  # has_one :blog

  attribute :name do
    object.user.name
  end

  attribute :blog_id do
    object.blog.id
  end

  attribute :created_at do
    object.created_at.strftime("%d %b %Y")
  end

 

end
