class JoinTableGossipTag < ApplicationRecord
  
  belongs_to :tag
  belongs_to :gossip

  def self.retrieve_tags(gossip_id)
    associated_tags = Array.new
    JoinTableGossipTag.all.each do |gossiptag|
      if gossiptag.gossip_id == gossip_id then associated_tags << Tag.find(gossiptag.tag_id).title end
    end
    return associated_tags
  end

end
