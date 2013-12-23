class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy]
  before_filter :not_signed_in,  only: [:new, :create]

  def index
    @users = User.paginate(
                    page: params[:page],
                    per_page: Cookmeasquid::Application::USER_PER_PAGE
                    )
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
      flash[:success] = "Registration successful !"
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
end
