require 'pry'
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    binding.pry
  end

  private 

  def post_params
    params.require(:post).permit(:title, :description, category_id: [])
  end


end