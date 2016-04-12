class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create] 
  before_action :require_admin, only: [:new, :create]


  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end
end