class GossipsController < ApplicationController

  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
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
      flash[:notice] = 'Successfully checked in'
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
