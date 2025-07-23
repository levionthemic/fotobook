# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    load_and_authorize_resource
    before_action :check_admin_only
    def index
      @users = User.all
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      old_status = @user.status
      form_type = params[:form_type]
      if form_type == "avatar"
        if current_user.update(avatar: params[:user][:avatar])
          redirect_to user_path(current_user), notice: "Avatar was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
        return
      end
      if @user.update(user_params)
        if old_status == "active" && user_params[:status] == "inactive"
          UserMailer.warning_inactive_mail(@user).deliver_now
        end
        redirect_to admin_users_path, notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:avatar, :first_name, :last_name, :email, :password, :password_confirmation, :status)
    end

    def check_admin_only
      unless current_user&.admin?
        redirect_to root_path, alert: "Bạn không có quyền truy cập trang admin."
      end
    end
  end
end
