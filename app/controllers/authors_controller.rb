class AuthorsController < ApplicationController
  def show
    @author = User.find(params[:id])
  end
end
