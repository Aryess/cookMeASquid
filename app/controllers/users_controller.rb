class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 50)
  end
  
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
      sign_in @user
      redirect_back_or @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Update successful!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
