class Blog < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user
  has_many :user_comments, through: :comments, source: :user
  
end
