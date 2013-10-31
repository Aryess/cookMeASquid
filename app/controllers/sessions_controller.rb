class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if(user && user.authenticate(params[:session][:password]))
      sign_in user
      flash[:success] = "Yay, welcome back!"
      redirect_to user
    else
      flash.now[:error] = "Invalid"
      render 'new'
    end
  end
  
  def destroy
    
    redirect_to root_path
  end
end
