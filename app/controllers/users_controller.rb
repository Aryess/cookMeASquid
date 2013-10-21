class UsersController < ApplicationController
  def new
  end
  
  def show
    begin
      @user = User.find(params[:id])
    rescue
      redirect_to root_path
    end
  end
end
