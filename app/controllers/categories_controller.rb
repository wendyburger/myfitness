class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end
end