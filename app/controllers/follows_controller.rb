# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    user_id = current_user.id
    following_id = params[:following_id]
    follow = Follow.new(follower_id: user_id, following_id: following_id)
    if follow.save
      redirect_to request.referer, notice: "Follow successful!"
    else
      render user_path(user_id, tab: "followers"), status: :unprocessable_entity
    end
  end

  def destroy
    # Hủy theo dõi
    user_id = current_user.id
    following_id = params[:id]
    Follow.destroy_by(follower_id: user_id, following_id: following_id)
    redirect_to user_path(user_id, tab: "followings"), notice: "Following was deleted."
  end

  private

  def is_follower_route?
    request.path.start_with?("/followers")
  end

  def set_target_user
    @target_user = User.find(params[:user_id])
  end
end
