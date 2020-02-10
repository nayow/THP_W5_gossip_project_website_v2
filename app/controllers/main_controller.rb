class MainController < ApplicationController

  def home
  end

  def team
  end

  def contact
  end

  def welcome
    @name = params[:name]
  end

  def gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def author
    @author = User.find(params[:author_id])
  end

end
