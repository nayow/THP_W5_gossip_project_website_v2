class CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new('content' => params[:comment], 'gossip_id' => params[:id], 'user_id' => User.where(first_name: 'anonymous').pluck('id')[0])
    if @comment.save
      redirect_to gossip_path(params[:id])
    else 
      render :gossips/show
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update('content' => params[:content])
      redirect_to gossip_path(@comment.gossip_id)
    else
      render :edit
    end
  end

  def destroy
    gossip_id = Comment.find(params[:id]).gossip_id #before it is destroyed
    Comment.destroy(params[:id])
    redirect_to gossip_path(gossip_id) #retrieve the gossips associated to the destroyed comment
  end

end
