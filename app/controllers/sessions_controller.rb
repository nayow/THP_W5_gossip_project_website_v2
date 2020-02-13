class SessionsController < ApplicationController
  def new
    # écran login
  end

  def create
    user = User.find_by('email' => params[:email])
    if user && user.authenticate(params[:pw])
      login(user) #helper
      redirect_to gossips_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    session.delete(:user_id)
    redirect_to gossips_path
  end
end
