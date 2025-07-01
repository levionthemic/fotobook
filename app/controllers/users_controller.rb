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

  def photos
  end

  def albums
  end

  def followers
  end

  def followings
  end
end
