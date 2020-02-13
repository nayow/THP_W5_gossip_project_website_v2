class UsersController < ApplicationController

  def show
    @author = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      'first_name' => params[:first_name],
      'last_name' => params[:last_name],
      'email' => params[:email],
      'password' => params[:pw],
      'city_id' => City.find_by('name' => params[:city]).id)
    if @user.save
      login(@user)
      redirect_to gossips_path
    else 
      render :new
    end
  end

end
