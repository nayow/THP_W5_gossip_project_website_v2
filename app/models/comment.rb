class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comment_of_comments
end
