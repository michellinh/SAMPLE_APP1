class FollowsController < ApplicationController
  before_action :loader_user, only: %i(following followers)

  def following
    @title = t "following"
    @users = @user.following.page(params[:page]).per Settings.p_page
    render "users/show_follow"
  end

  def followers
    @title = t "followers"
    @users = @user.followers.page(params[:page]).per Settings.p_page
    render "users/show_follow"
  end

  private

  def loader_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "no_exist"
    redirect_to root_url
  end
end
