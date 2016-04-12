class RecipesController < ApplicationController
  before_filter :require_user, only: [:new, :create]
  before_action :set_recipe, only: [:show, :edit, :update] 
  before_action :require_creator, only: [:edit, :update]


  def index
    @recipes = Recipe.all    
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.creator = current_user
    if @recipe.save
      flash[:notice] = '你成功新增食譜'
      redirect_to @recipe
    else
      render :new
    end
  end

  def show 
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:notice] = '你已成功更新食譜'
      redirect_to @recipe
    else
      render :edit
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:dishname, :protocol, :image)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @recipe.creator)
  end
end