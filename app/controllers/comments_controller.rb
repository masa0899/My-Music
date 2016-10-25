class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment: comments_params[:comment], post_id: comments_params[:post_id], user_id: current_user.id)
    redirect_to "/posts/#{@comment.post.id}"
  end

  private
  def comments_params
    params.permit(:comment, :post_id)
  end
end
