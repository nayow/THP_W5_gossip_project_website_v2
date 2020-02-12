class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comment_of_comments

  validates :content, presence: true

  def self.count(gossip_id)
    return Comment.where('gossip_id' => gossip_id).count
  end

end
