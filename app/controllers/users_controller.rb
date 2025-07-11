class UsersController < ApplicationController
  def show
    @param_user_id = params[:id]
    @user = User.includes(:photos, :albums, :followings, :followers).find(params[:id])
    @tab = params[:tab] || "photos"
    @items = []

    if user_signed_in? && current_user.id != @param_user_id.to_i
      case @tab
      when "photos"
        @items = @user.photos.filter { |e| e.sharing_mode == "public_mode" }
      when "albums"
        @items = @user.albums.filter { |e| e.sharing_mode == "public_mode" }
      when "followers"
        @items = @user.followers
      when "followings"
        @items = @user.followings
      end
      return
    end

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
