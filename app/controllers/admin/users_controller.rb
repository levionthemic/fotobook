# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    ITEMS_PER_PAGE = 20

    include AdminMethods

    load_and_authorize_resource
    before_action :get_user, only: [:edit, :update, :destroy]

    def index
      @users = User.page(params[:page]).per(ITEMS_PER_PAGE)
    end

    def edit
    end

    def update
      @user.skip_reconfirmation!
      old_status = @user.status
      form_type = params[:form_type]
      if form_type == "avatar"
        if @user.update(avatar: params[:user][:avatar])
          redirect_to admin_users_path, notice: "Avatar was successfully updated."
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

    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: "Delete user successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:avatar, :first_name, :last_name, :email, :password, :password_confirmation, :status)
    end

    def get_user
      @user = User.find(params[:id])
    end
  end
end
