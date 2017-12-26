class FollowsController < ApplicationController
  before_action :logged_in_user

  def following
    @title = "Following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end
  
end
