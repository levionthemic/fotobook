# frozen_string_literal: true

module UsersHelper
  def is_following?(following_id)
    @user.followings.any? { |u| u.id == following_id }
  end
end
