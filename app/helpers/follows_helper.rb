module FollowsHelper
  def following?(user_id)
    if user_signed_in?
      Follow.exists?(follower_id: current_user.id, following_id: user_id)
    else
      false
    end
  end
end
