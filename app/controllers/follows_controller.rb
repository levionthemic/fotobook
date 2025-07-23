# frozen_string_literal: true

class FollowsController < ApplicationController
  load_and_authorize_resource

  def create
    user_id = current_user.id
    following_id = params[:following_id]
    follow = Follow.new(follower_id: user_id, following_id: following_id)
    if follow.save
      respond_to do |format|
        format.turbo_stream  # create.turbo_stream.erb
        format.html { redirect_to request.referer, notice: "Followed!" }
      end
    else
      render user_path(user_id, tab: "followers"), status: :unprocessable_entity
    end
  end

  def destroy
    user_id = current_user.id
    following_id = params[:following_id]
    follow = Follow.find_by(follower_id: user_id, following_id: following_id)

    if follow
      follow.destroy!
      redirect_to user_path(user_id, tab: "followings"), notice: "Following was deleted."
    else
      redirect_to user_path(user_id, tab: "followings"), alert: "Follow not found or unauthorized."
    end
  end


  private

  def is_follower_route?
    request.path.start_with?("/followers")
  end

  def set_target_user
    @target_user = User.find(params[:user_id])
  end
end
