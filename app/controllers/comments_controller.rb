class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Comment successfully added'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(vote: params[:vote], creator: current_user, voteable: comment)

    if vote.valid?
      flash[:notice] = 'Thank you for your vote'
    else
      flash[:error] = 'There was an error, voting unsuccessful'
    end

    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end