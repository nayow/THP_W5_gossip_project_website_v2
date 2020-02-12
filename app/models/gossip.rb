class Gossip < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :join_table_gossips_tags
  has_many :tags, through: :join_table_gossips_tags

  validates :title, presence: true, length: { in: 3..14 }
  validates :content, presence: true

end
