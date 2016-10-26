class PostsController < ApplicationController

  def index
    # binding.pry
    @posts = Post.all.order('created_at DESC')
    @likes = Like.where(user_id: current_user)
  end

  def new
  end

  def create
    Post.create(song_title: post_params[:song_title], singer: post_params[:singer], youtube_url: post_params[:youtube_url], text: post_params[:text], user_id: current_user.id)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.update(post_params)
    end
  end

  private
  def post_params
    params.permit(:song_title, :singer, :youtube_url, :text)
  end
end
