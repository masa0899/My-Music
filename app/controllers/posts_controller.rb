class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    Post.create(song_title: post_params[:song_title], singer: post_params[:singer], youtube_url: post_params[:youtube_url], text: post_params[:text], user_id: current_user.id)
  end

  private
  def post_params
    params.permit(:song_title, :singer, :youtube_url, :text)
  end
end