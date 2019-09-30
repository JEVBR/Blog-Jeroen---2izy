class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    @comment.save
    redirect_to post_path(@post), notice: 'Comment was sucessfully created'
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :name)
  end
end
