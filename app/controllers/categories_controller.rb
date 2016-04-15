class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create] 
  before_action :require_admin, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
    if @category.save
      redirect_to root_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end
end