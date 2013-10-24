class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    begin
      @user ||= User.find(params[:id])
    rescue
      flash[:error] = "Nothing to see here!"
      redirect_to root_path
    end
  end
  
  def create
   
    @user = User.new(params[:user])
    if(@user.save)
      flash[:success] = "Registration successful!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit( :name,
                                    :surname,
                                    :age,
                                    :login,
                                    :email, 
                                    :password,
                                    :password_confirmation)
    end
end
