class LikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]
  
  def create
  	if already_liked?
  		Like.find_by(gossip_id: params[:gossip_id], user_id: current_user.id).destroy
  		redirect_to request.referrer
  		flash[:danger] = "Unlike"
  	else
  		@like = Like.create('gossip_id' => params[:gossip_id], 'user_id' => current_user.id)
  		redirect_to request.referrer
  		flash[:success] = "Like"
  	end
  end

  private

   def authenticate_user
    unless current_user
      flash[:danger] = "Please log in!"
      redirect_to new_session_path
    end
  end

  def already_liked?
    users = Like.where('gossip_id' => params[:gossip_id]).pluck('user_id')
    users.include?(current_user.id) ? true : false
  end

end
