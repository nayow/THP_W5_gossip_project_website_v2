class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
  before_action :is_author?, only: [:edit, :update, :destroy]

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new('title' => params[:title], 'content' => params[:content], 'user_id' => current_user.id)
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

  def index
    # on code quelque chose qui permet d'afficher le dashboard de l'utilisateur
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

  def is_author?
    unless current_user.id == Gossip.find(params[:id]).user.id
      flash[:danger] = "You can't edit someone else's gossip"
      redirect_to gossip_path(params[:id])
    end
  end

end
