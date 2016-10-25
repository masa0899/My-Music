class LikesController < ApplicationController

  before_action :set_post

  def create
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    @like = Like.where(user_id: current_user)
    @post.reload
    # @posts = Post.all
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
    @likes = Like.where(user_id: current_user)
    @post.reload
    # @posts = Post.all
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
end
