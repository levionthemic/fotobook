# frozen_string_literal: true

module LikesHelper
  def liked?(view_user_id)
    @likes_by_user.any? { | _, user_id | user_id.to_i == view_user_id.to_i }
  end

  def get_like_id_by_user(view_user_id)
    @likes_by_user.select { |_, user_id| user_id.to_i == view_user_id.to_i }.first
  end
end
