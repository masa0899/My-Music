class LikesController < ApplicationController

  before_action :set_post

  def create
    Like.create(user_id: current_user.id, post_id: params[:id])
    @likes = Like.where(user_id: current_user.id)
    @post = Post.find(params[:id])
    @index = params[:index]
    @posts = Post.all

    respond_to do |format|
        format.json{ render json: {counts: Like.where(post_id: params[:id]).count}}
      end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    @like.destroy
    @likes = Like.where(user_id: current_user.id)
    @index = params[:index]
    @posts = Post.all
    respond_to do |format|
        format.json{ render json: {counts: Like.where(post_id: params[:id]).count}}
      end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
