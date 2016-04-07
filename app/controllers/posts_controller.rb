class PostsController < ApplicationController
  before_filter :require_user, only:[:new, :create]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit 
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "你已經成功更新文章"
      redirect_to @post
    else
      render :edit
    end
  end


  private 

  def post_params
    params.require(:post).permit(:title, :description, :content, :image, :category_id)
  end
end