class PostsController < ApplicationController
  before_filter :require_user, only:[:new, :create]
  before_action :set_post, only:[:edit, :update, :show]
  before_action :require_creator, only: [:edit, :update]
  
  def index
    @posts = Post.all
    @categories = Category.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "你已經成功新增文章"
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:creator)
  end

  def edit 
  end

  def update
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

  def set_post
    @post = Post.find(params[:id])
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.user)
  end
end