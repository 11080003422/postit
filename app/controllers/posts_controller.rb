class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]

  def set_post
    @post = Post.find_by_slug(params[:id])
  end

  def index
    @posts = Post.all.sort_by {|x| x.vote_sum}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.creator = current_user

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

  def vote
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
end
