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

  def update
    @user = User.find(params[:id])
    if params[:user][:avatar]
      if @user.update(avatar: params[:user][:avatar])
        redirect_to user_path(@user), notice: "Avatar was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
      return
    end
    permitted_params_1 = params.require(:user).permit(:first_name, :last_name, :email)
    if @user.update(permitted_params_1)
      redirect_to user_path(@user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def photos
    @user = User.find(params[:id])
    @items = @user.photos
    @tab = "photos"
    render "users/show"
  end

  def albums
    @user = User.find(params[:id])
    @items = @user.albums
     @tab = "albums"
    render "users/show"
  end

  def followers
    @user = User.find(params[:id])
    @items = @user.followers
     @tab = "followers"
    render "users/show"
  end

  def followings
    @user = User.find(params[:id])
    @items = @user.followings
    @tab = "followings"
    render "users/show"
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
