class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def set_post
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.creator = User.first

    if @post.save
      flash[:notice] = 'Post successfully created'
      redirect_to posts_path
    else
      render 'posts/new'
    end
  end

  def edit; end

  def update
    if @post.update post_params
      flash[:notice] = 'Post successfully updated'
      redirect_to posts_path
    else
      render 'posts/edit'
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end
end
