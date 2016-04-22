class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to home_path
    else
      render :new
    end
  end

  def edit
  end

  def update    
    if @user.update(user_params)
      flash[:notice] = "你已經成功更新資料"
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @recipes = @user.recipes
    @posts = @user.posts.includes(:category)
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :full_name, :avatar, :time_zone)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:notice] = "非本人不允許這麼做"
      redirect_to root_path
    end
  end
end