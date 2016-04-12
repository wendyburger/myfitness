class RecipesController < ApplicationController
  before_action :set_recipe 

  def index
    @recipes = Recipe.all    
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = '你成功新增食譜'
      redirect_to recipes_path
    else
      render :new
    end
  end

  def show 
  end

  private
  def recipe_params
    params.require(:recipe).permit(:dishname, :protocol, :image)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end