class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = '你成功新增評論'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def show
  end

end