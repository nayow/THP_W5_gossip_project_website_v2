class Gossip < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :join_table_gossips_tags
  has_many :tags, through: :join_table_gossips_tags

end
