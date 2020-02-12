class GossipsController < ApplicationController

  def index
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new('title' => params[:title], 'content' => params[:content], 'user_id' => User.where(first_name: 'anonymous').pluck('id')[0])
    if @gossip.save
      JoinTableGossipTag.create('gossip_id' => @gossip.id , 'tag_id' => Tag.where(title: params[:tag]).pluck('id')[0])
      redirect_to gossips_path
    else 
      render :new
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update('title' => params[:title], 'content' => params[:content])
      redirect_to gossips_path
    else
      render :edit
    end
  end

  def destroy
    Gossip.destroy(params[:id])
    redirect_to gossips_path
  end

end
