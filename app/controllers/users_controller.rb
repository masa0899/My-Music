class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = current_user.nickname
    @posts = current_user.posts.order('created_at DESC').page(params[:page]).per(6)
  end

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to acton: "index"
end

private
def update_params
  params.require(:user).permit(:nickname, :avatar)
end
end
