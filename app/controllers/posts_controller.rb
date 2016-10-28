class PostsController < ApplicationController

  require 'rubygems'
  require 'google/api_client'
  require 'trollop'

  def index
    @posts = Post.all.order('created_at DESC').page(params[:page]).per(6)
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

  def search
  end

#youtube api
  def search_movie
    $search_word = params[:search_word]



   opts = Trollop::options do
     opt :q, $search_word, :type => String, :default => $search_word
     opt :max_results, 'Max results', :type => :int, :default => 25
   end

   client, youtube = get_service

   begin
     # Call the search.list method to retrieve results matching the specified
     # query term.
     search_response = client.execute!(
       :api_method => youtube.search.list,
       :parameters => {
         :part => 'snippet',
         :q => opts[:q],
         :maxResults => opts[:max_results]})

     @videos = []
     @channels = []
     @playlists = []

     # Add each result to the appropriate list, and then display the lists of
     # matching videos, channels, and playlists.
     search_response.data.items.each do |search_result|
       case search_result.id.kind
       when 'youtube#video'
         @videos << search_result
       when 'youtube#channel'
         @channels << search_result
       when 'youtube#playlist'
         @playlists << search_result
       end
     end
   rescue Google::APIClient::TransmissionError => e
     flash.now[:error] = e.result.body
     render action: :index
     return false
   end


 end


  private
  def get_service
    client = Google::APIClient.new(
      :key => 'AIzaSyA1icUIFmxUNDrrdU3qA6PQkwQbqryi9vA',
      :authorization => nil,
      :application_name => 'My Music',
      :application_version => '1.0.0'
    )
    youtube = client.discovered_api('youtube','v3')
    return client, youtube
  end

  def post_params
    params.permit(:song_title, :singer, :youtube_url, :text)
  end
end
