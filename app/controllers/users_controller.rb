class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :reject_admin_access, only: [:edit, :update]

  def show
    @param_user_id = params[:id]
    @user = User.includes(:photos, :albums, :followings, :followers).find(params[:id])
    @tab = params[:tab] || "photos"
    @items = []

    case @tab
    when "photos"
      @items = @user.photos.public_m
      if current_user.id == @param_user_id.to_i
        @items = @user.photos
      end
    when "albums"
      @items = @user.albums.public_m
      if current_user.id == @param_user_id.to_i
        @items = @user.albums
      end
    when "followers"
      @items = @user.followers.where.not(id: current_user.id)
    when "followings"
      @items = @user.followings.where.not(id: current_user.id)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    form_type = params[:form_type]
    if form_type == "avatar"
      if current_user.update(avatar: params[:user][:avatar])
        redirect_to user_path(current_user), notice: "Avatar was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
      return
    end
    if form_type == "basic"
      permitted_params_1 = params.require(:user).permit(:first_name, :last_name, :email)
      if current_user.update(permitted_params_1)
        redirect_to user_path(current_user), notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
      return
    end

    if form_type == "password"
      permitted_params_2 = params.require(:user).permit(:current_password, :password, :password_confirmation)
      if permitted_params_2[:password].blank?
        @user.errors.add(:password, "can't be blank")
      end

      if permitted_params_2[:password_confirmation].blank?
        @user.errors.add(:password_confirmation, "can't be blank")
      end
      if @user.errors.any?
        render :edit, status: :unprocessable_entity
        return
      end
      if current_user.update_with_password(permitted_params_2)
        bypass_sign_in(current_user)
        redirect_to user_path(current_user), notice: "Password updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def reject_admin_access
    if current_user.admin?
      redirect_to root_path
    end
  end
end
