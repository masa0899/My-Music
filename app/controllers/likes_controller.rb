class LikesController < ApplicationController

  before_action :set_post

  def create
    Like.create(user_id: current_user.id, post_id: params[:id])
    @likes = Like.where(user_id: current_user)
    @post = Post.find(params[:id])
    @index = params[:index]
    # @post.reload
    # @likes = Like.where(user_id: current_user)
    @posts = Post.all
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    @like.destroy
    @likes = Like.where(user_id: current_user)
    @index = params[:index]
    # @post.reload
    @posts = Post.all
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
