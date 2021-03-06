class User < ApplicationRecord
    has_many :blogs, dependent: :destroy
    has_many :likes, dependent: :destroy 
    has_many :comments, dependent: :destroy
    has_many :liked_blogs, through: :likes, source: :blog
    has_many :commented_blogs, through: :comments, source: :blog
    has_many :lists, dependent: :destroy
    has_many :tasks, through: :lists
    
    validates :email, uniqueness: true
    has_secure_password
    
end
