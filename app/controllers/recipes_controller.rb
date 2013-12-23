class RecipesController < ApplicationController
  before_filter :signed_in_user,  only: [:new, :edit, :update, :destroy]
  before_filter :admin_user,      only: [:new, :edit, :update, :destroy]

  def index
    @recipes = Recipe.paginate(
                        page: params[:page],
                        per_page: Cookmeasquid::Application::RECIPE_PER_PAGE
                        )
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
