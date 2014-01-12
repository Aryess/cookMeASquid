class RecipesController < ApplicationController
  before_filter :signed_in_user,  only: [:new, :edit, :update, :destroy]
  before_filter :admin_user,      only: [:new, :edit, :update, :destroy]

  def index

    if (params[:diff] && params[:diff].to_i != 0\
      && params[:serving] && params[:serving].to_i)
      if params[:serving].to_i != 0
        @recipes = Recipe.where("difficulty <= #{params[:diff].to_i}")
                         .where("serving = #{params[:serving].to_i}")
                         .paginate(
                            page: params[:page],
                            per_page: Cookmeasquid::Application::RECIPE_PER_PAGE
                            )
     else
        @recipes = Recipe.where("difficulty <= #{params[:diff].to_i}")
                         .paginate(
                            page: params[:page],
                            per_page: Cookmeasquid::Application::RECIPE_PER_PAGE
                            )
      end
    end
  end

  def create
  	@recipe = Recipe.new(params[:recipe])
    if @recipe.save
      flash[:success] = "Recipe added"
      redirect_to @recipe
    else
  	 render 'new'
    end
  end

  def new
  	@recipe = Recipe.new
  end

  def show
    begin
      @recipe ||= Recipe.find(params[:id])
      @comment = current_user.comments.build
    rescue
      flash[:error] = "Nothing to see here!"
      redirect_to root_path
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      flash[:success] = "Update successful!"
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe removed"
    redirect_to recipes_url
  end
end
