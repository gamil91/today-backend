class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :user_id
  has_one :user
  has_one :blog

  attribute :name do
    object.user.name
  end

 

end
