# frozen_string_literal: true

module UsersHelper
  def is_following?(following_id)
    user =  current_user.followings.find_by(id: following_id)
    if user
      return true
    end
    false
  end
end
