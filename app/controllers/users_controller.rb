class UsersController < ApplicationController
  def show
    @param_user_id = params[:id]
    @user = User.find(params[:id])
    @tab = params[:tab] || "photos"

    case @tab
    when "photos"
      @items = @user.photos
    when "albums"
      @items = @user.albums
    when "followers"
      @items = @user.followers
    when "followings"
      @items = @user.followings
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def photos
  end

  def albums
  end

  def followers
  end

  def followings
  end

  # --------------------------------------------------
  def admin_show_users
    @users = User.all
    render "admin/users"
  end

  def admin_show_user_detail
    @user = User.find(params[:id])
    render "admin/user"
  end
end
